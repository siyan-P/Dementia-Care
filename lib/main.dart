import 'package:flutter/material.dart';
import 'package:flutter_application_4/local_db/db_functions.dart';
import 'package:flutter_application_4/pages/screen_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  openDB();
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
        primaryColor: Colors.pink,
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      home: const screen_splash(),
    );
  }
}
