import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/vendorscreen/add_product/add_product.dart';

import '../../loginscreen/login_screen.dart';
import '../../utilties/colors.dart';
import '../buyer/home/buyer_home.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: KprimaryColor,
                height: 50,
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuyerHome()));
                },
                child: Text(
                  'Find Products',
                  style: TextStyle(color: kwhiteColor, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: KprimaryColor,
                height: 50,
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductScreen()));
                },
                child: Text(
                  'Start as a vendor',
                  style: TextStyle(color: kwhiteColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
