import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoping_app/screens/welcome/welcome_screen.dart';
import 'package:shoping_app/signupscreen/signup_screen.dart';

import '../main.dart';
import '../screens/forgotscreen/forgot_screen.dart';
import '../utilties/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool securePassword = true;

  signin() async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      box.write('uid', credential.user!.uid);
      box.write('islogin', true);
      EasyLoading.showToast('Successfully Signin');
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => WelcomeScreen()),
      //         (route) => false);


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError('Wrong password provided for that user.');

      }
    }




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(fontSize: 16.5, color: ksecondaryColor),
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
                      height: 15,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotScreen()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: redColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
                          EasyLoading.show();
                          signin();

                        }
                      },
                      child: Text(
                        'Sign In',
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
                                builder: (context) => SignUpScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont have an account?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
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
