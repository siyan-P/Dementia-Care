import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';

class screen_splash extends StatefulWidget {
  const screen_splash({Key? key}) : super(key: key);

  @override
  State<screen_splash> createState() => _screen_splashState();
}

class _screen_splashState extends State<screen_splash> {
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
}
