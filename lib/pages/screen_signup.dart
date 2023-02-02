import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/screen_home.dart';
import 'package:http/http.dart';

class screen_signup extends StatelessWidget {
  screen_signup({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  Future<void> login(
      String email, String pass, String username, BuildContext ctx) async {
    try {
      Response response = await post(
          Uri.parse('https://dementia.cianlogic.com/accounts/register/'),
          body: {
            'username': username,
            'email': email,
            'password': pass,
            'password2': pass,
          });
      // print(email);
      // print(pass);
      if (response.statusCode == 200) {
        print("account created succssefull");
        final data = jsonDecode(response.body);
        final token = data['token'];
        print(token);

        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder: (context) => screen_home(
                      null,
                      null,
                      null,
                      username,
                    )));
      } else {
        print("faild to creating account");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    "images/Dementia-1-removebg-preview.jpg",
                    height: 160,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    "SignUp Here!",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(left: 28, right: 28, bottom: 10),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pls enter some data';
                        }
                        return null;
                      },
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
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pls enter some data';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        // errorBorder:
                        border: OutlineInputBorder(),
                        hintText: 'octavia_s',
                        labelText: 'user name',
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
                      controller: passController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pls enter some data';
                        }
                        if (value.length < 4) {
                          return 'password must be atleast 4 letters';
                        }
                        return null;
                      },
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
                      obscureText: true,
                      // validator: (value) {
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pls enter some data';
                        }
                        if (value != passController.text)
                          return 'password not match';
                        return null;
                      },

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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: GestureDetector(
                      onTap: () {
                        //  go to screen_home with name and email.
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData, accessToken)));
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          login(
                              emailController.text.toString(),
                              passController.text.toString(),
                              usernameController.text.toString(),
                              context);
                        }
                        // if(status)
                        // {

                        // }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(const Radius.circular(15)),
                            color: Colors.pink.shade700),
                        height: 33,
                        //  color: Colors.pink.shade700,
                        alignment: Alignment.center,
                        child: const Text(
                          "SignUp and Proceed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => screen_login()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
