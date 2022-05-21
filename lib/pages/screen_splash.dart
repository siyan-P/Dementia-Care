import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_login.dart';

class screen_splash extends StatelessWidget {
  const screen_splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "images/dementia_login_whi.png",
                        height: 200,
                      )),
                  const Text(
                    "Dementia\n Health Care",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Image.asset(
                    "images/wecome.jpg",
                    height: 180,
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const screen_login(),
                          ));
                    },
                    icon: const Icon(Icons.follow_the_signs_rounded),
                    label: const Text("Gets Start!"),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    side:
                                        BorderSide(color: Colors.lightBlue)))),
                  ),
                ],
              )),
        ));
  }
}
