import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/screen_home.dart';

class screen_signup extends StatelessWidget {
  const screen_signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "images/dementia_login_whi.png",
                      height: 135,
                    )),
                const Text(
                  "SignUp Here!",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  "images/login.jpg",
                  height: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.only(left: 28, right: 28, bottom: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      // errorBorder:
                      border: OutlineInputBorder(),
                      hintText: 'eg: octavia@123',
                      labelText: 'user name',
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.person_pin_circle_outlined),
                      suffixIconColor: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.only(left: 28, right: 28, bottom: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      // errorBorder:
                      border: OutlineInputBorder(),
                      hintText: 'eg: octavia123@gmail.com',
                      labelText: 'user email',
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixIconColor: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.only(left: 28, right: 28, bottom: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      // errorBorder:
                      border: OutlineInputBorder(),
                      hintText: 'eg: octavia@123',
                      labelText: 'password',
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIconColor: Colors.blue,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.only(left: 28, right: 28, bottom: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      // errorBorder:
                      border: OutlineInputBorder(),
                      hintText: 'eg: octavia@123',
                      labelText: 'conform password',
                      fillColor: Colors.grey,
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIconColor: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Or register via Social Accounts?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () {
                      //go to screen_home with name and email.
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData, accessToken)));
                    },
                    child: const Text("SignUp")),
                       Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => screen_login()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
