import 'package:flutter/material.dart';
import 'package:flutter_application_4/consts/constands.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/pages/screen_signup.dart';

class screen_registration extends StatelessWidget {
  const screen_registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "images/dementia_login_whi.png",
                      height: 150,
                    )),
                const Text(
                  "Dementia Care \n Registration",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  "images/login.jpg",
                  height: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //  height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: color.myColor,
                      //   color: Colors.blueGrey
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.white)))),
                            child: const Text(
                              'SignUp using userData',
                              //  style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => screen_signup()));
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.white)))),
                            child: const Text(
                              'SignUp using facebook',
                            ),
                            onPressed: () {},
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.white)))),
                            child: const Text(
                              'SignUp using Google',
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have an Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
