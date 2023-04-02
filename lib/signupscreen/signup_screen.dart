import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoping_app/loginscreen/login_screen.dart';
import 'package:shoping_app/screens/welcome/welcome_screen.dart';

import '../main.dart';
import '../utilties/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  bool securePassword = true;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  signup() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      return users
          .add({
            'firstname': firstName.text, // John Doe
            'lastname': lastName.text, // Stokes and Sonsq
            'email': email.text, // 42
            'id': credential.user!.uid,
          })
          .then((value) => print("User Added"))
          .whenComplete(() {
            box.write('uid', credential.user!.uid);
            box.write('islogin', true);
            EasyLoading.showToast('Successfully Signup');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (route) => false);
          })
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.showError('The password is to short.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError('The account already exists for that email.');
      }
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Create Account',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter your Credentials to continue',
                      style: TextStyle(fontSize: 16.5, color: ksecondaryColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: firstName,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter first name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: "Enter your first name",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 230, 142, 11),
                            )),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: lastName,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter last name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: "Enter your last name",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 230, 142, 11),
                            )),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: "Please enter your email",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 230, 142, 11),
                            )),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter password";
                        }
                        return null;
                      },
                      obscureText: securePassword,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Please enter your password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                securePassword = !securePassword;
                              });
                            },
                            icon: Icon(securePassword
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 230, 142, 11),
                            )),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      color: KprimaryColor,
                      height: 50,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup();
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: kwhiteColor, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
