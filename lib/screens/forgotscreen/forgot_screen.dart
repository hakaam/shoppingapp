import 'package:flutter/material.dart';
import 'package:shoping_app/utilties/colors.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Forget Password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please enter your valid email',
                  style: TextStyle(
                    fontSize: 16.5,
                    color: ksecondaryColor
                  ),
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
                SizedBox(height: 15,),
                MaterialButton(
                  color: KprimaryColor,
                  height: 50,
                  minWidth: double.maxFinite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text(
                    'Reset Password',
                    style: TextStyle(color: kwhiteColor, fontSize: 16),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
