import 'package:flutter/material.dart';

class screen_guidlines extends StatelessWidget {
  const screen_guidlines({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Icon(Icons.warning_amber),
              Text("page under constraction!")
            ],
          ),
        ),
      ),
    );
  }
}