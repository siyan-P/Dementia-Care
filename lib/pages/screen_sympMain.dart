import 'package:flutter/material.dart';

class screen_sympMain extends StatelessWidget {
  const screen_sympMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.warning_amber_rounded),
                Text("Page under constraction!")
              ],
            ),
          )
          ));
    
  }
}
