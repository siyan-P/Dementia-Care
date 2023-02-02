import 'package:flutter/material.dart';
import 'package:flutter_application_4/main.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/pages/temp.dart';
import 'package:flutter_application_4/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:awesome_notifications/awesome_notifications.dart';
String SAVE_KEY_NAME = '';
String SAVE_USER_NAME = '';

class screen_splash extends StatefulWidget {
  const screen_splash({Key? key}) : super(key: key);

  @override
  State<screen_splash> createState() => _screen_splashState();
}

class _screen_splashState extends State<screen_splash> {
  @override
  void initState() {
    // TODO: implement initState
    CheckUseLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "images/Dementia-1-removebg-preview.jpg",
                      height: 280,
                    ),
                  ),
                  const SizedBox(
                    height: 230,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Get's Start!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.pink),
                      ),
                      // Icon(Icons.follow_the_signs_rounded)
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screen_login(),
                              ));
                        },
                        icon: Icon(Icons.read_more_rounded),
                        iconSize: 38,
                        color: Colors.pink,
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

  //shared preferences -->checking
  Future<void> CheckUseLoggedIn() async {
    final _shardPref = await SharedPreferences.getInstance();
    var _userLoggedIn = _shardPref.getString('SAVE_KEY_NAME');
    var _userDetails = _shardPref.getString('SAVE_USER_NAME');
    setState(() {
      SAVE_KEY_NAME = _userLoggedIn!;
      SAVE_USER_NAME = _userDetails!;
    });
    if (_userLoggedIn == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen_login(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen_home(null, null, null, SAVE_USER_NAME),
          ));
    }
  }
}
