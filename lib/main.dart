import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/googledemo.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/pages/screen_splash.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dementia care App',
      theme: ThemeData(
  
      primaryColor: Colors.cyan,
      ),
      // 
    //  theme: ThemeData(scaffoldBackgroundColor: Colors.white.withOpacity(100)),
      home:  screen_splash(),
    );
  }
}

