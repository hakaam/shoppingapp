import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('app'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(child: Text('Drink',
              style: TextStyle(
                color: Colors.white


              ),

            )),
          )
        ],
      ),
    );
  }
}
