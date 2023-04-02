import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/loginscreen/login_screen.dart';
import 'package:shoping_app/screens/splash/splash_screen.dart';
import 'package:shoping_app/utilties/variable_scren.dart';
import 'package:get_storage/get_storage.dart';

import 'home.dart';


final box = GetStorage();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
    );
  }
}


