import 'package:flutter/material.dart';
import 'package:shoping_app/loginscreen/login_screen.dart';
import 'package:shoping_app/main.dart';

import '../welcome/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      if (box.read('islogin')==true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (route) => false);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    return const SafeArea(
      child: Scaffold(backgroundColor: Colors.blue, body: Text('Dev Shop')),
    );
  }
}
