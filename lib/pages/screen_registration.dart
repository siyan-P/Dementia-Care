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
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "images/Dementia-1-removebg-preview.jpg",
                height: 160,
              ),
              Text(
                "REGISTRATION",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.pink.shade700),
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => screen_signup(),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(15)),
                                    color: Colors.pink.shade700),
                                height: 33,
                                //  color: Colors.pink.shade700,
                                alignment: Alignment.center,
                                child: const Text(
                                  "SignUp With userData",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("OR"),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                //login-->facebook
                                //  _login();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.grey.shade200),
                                height: 33,
                                //  color: Colors.pink.shade700,
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(Icons.google),
                                    Image.asset("images/fb.png"),
                                    Text(
                                      "SignUp With Facebook",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("OR"),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                // if (_formKey.currentState!.validate()) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text('Processing Data')),
                                //   );
                                //   //navigation to  home page

                                // }
                              },
                              child: GestureDetector(
                                onTap: () {
                                  //Login with google-->google
                                  //  _handleSignIn();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Colors.redAccent.shade100),
                                  height: 33,
                                  //  color: Colors.pink.shade700,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/google-plus.png",
                                        height: 22,
                                      ),
                                      Text(
                                        "SignUp With Google",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
