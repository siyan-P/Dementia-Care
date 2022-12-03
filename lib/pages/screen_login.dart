import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/local_db/data_model.dart';
import 'package:flutter_application_4/pages/googledemo.dart';
import 'package:flutter_application_4/pages/screen_registration.dart';
import 'package:flutter_application_4/sample.dart';
import 'package:flutter_application_4/screen_home.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class screen_login extends StatefulWidget {
  screen_login({Key? key}) : super(key: key);

  @override
  State<screen_login> createState() => _screen_loginState();
}

class _screen_loginState extends State<screen_login> {
  TextEditingController emailControllerL = TextEditingController();
  TextEditingController passControllerL = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //facebook
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  //google
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId,
    // clientId:
    //   '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();
    _checkIfIsLogged(); //facebook check whether is it logged or not?
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print("sample $account");
      setState(() {
        _currentUser = account;
      });
      // if (_currentUser != null) {
      //   _handleGetContact(_currentUser!);
      // }
    });
    _googleSignIn.signInSilently();
  }

  //google --display the current user information,(now it is not in our project)
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    // setState(() {
    //   _contactText = 'Loading contact info...';
    // });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  //google
  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  //google sign in and signout
  Future<void> _handleSignIn() async {
    try {
      _googleSignIn.signIn().then((value) => {
            _currentUser != null
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => screen_home(
                              null,
                              null,
                              _currentUser,
                            )))
                : null
          });

      // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      //   setState(() {
      //     _currentUser = account;
      //   });

      //   if (_currentUser != null) {
      //     _handleGetContact(_currentUser!);
      //     //   _currentUser != null ? Navigator.push(
      //     // context, MaterialPageRoute(builder: (context) => screen_home(null,null,_currentUser,))) : null;
      //   }
      //   _googleSignIn.signInSilently();
      // });

    } catch (error) {
      print(error);
    }
    _currentUser != null
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => screen_home(
                      null,
                      null,
                      _currentUser,
                    )))
        : null;
  }

  // google account signOut
  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  //facebook check if the user is loged or not
  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData,_accessToken)));
      setState(() {
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData,_accessToken)));
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  //facebook-login
  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData,_accessToken)));
      setState(() {
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData,_accessToken)));
        _userData = userData;
      });
    }

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
      var _email = _userData!['email'];
      //disply the current user info:
      print(_userData!["email"]);
      print(_userData!["name"]);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => screen_home(userData, accessToken, null)));
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }

//-->login with username and password
  Future<void> login(String email, pass, BuildContext ctx) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': pass,
      });
      if (response.statusCode == 200) {
        print("account created succssefully");
        //navigate to home page
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder: (context) => screen_home(
                      null,
                      null,
                      null,
                      email,
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _checking
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.zero,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 50),
                          Image.asset(
                            "images/Dementia-1-removebg-preview.jpg",
                            height: 160,
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                left: 28, right: 28, bottom: 10),
                            child: TextFormField(
                              controller: emailControllerL,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'pls enter some data';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                // errorBorder:
                                border: OutlineInputBorder(),
                                hintText: 'eg: octavia@123',
                                labelText: 'user email',
                                fillColor: Colors.pinkAccent,
                                prefixIcon:
                                    Icon(Icons.person_pin_circle_outlined),
                                suffixIconColor: Colors.pinkAccent,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 28, right: 28),
                            child: TextFormField(
                              cursorColor: Colors.pink,
                              controller: passControllerL,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'pls enter some data';
                                }
                                if (value.length < 4) {
                                  return 'passwors must be atleast 4';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                // errorBorder:
                                border: OutlineInputBorder(),
                                hintText: 'octavia',
                                labelText: 'Password',

                                fillColor: Colors.pink,
                                prefixIcon: Icon(Icons.password),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              //function to add forgott password!
                            },
                            child: const Text(
                              'Forgott Password?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 6),

                          Padding(
                            padding: const EdgeInsets.only(left: 28, right: 28),
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                  login(emailControllerL.text.toString(),
                                      passControllerL.text.toString(), context);
                                  //navigation to  home page

                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: Colors.pink.shade700),
                                height: 33,
                                //  color: Colors.pink.shade700,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Or Login with Social media",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 28, right: 28),
                            child: GestureDetector(
                              onTap: () {
                                //login-->facebook
                                _login();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
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
                                    const Text(
                                      "Sign In with Facebook",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          //UI for google signIn button
                          Padding(
                            padding: const EdgeInsets.only(left: 28, right: 28),
                            child: GestureDetector(
                              onTap: () {
                                //Login with google-->google
                                _handleSignIn();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.redAccent.shade100),
                                height: 33,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/google-plus.png",
                                      height: 22,
                                    ),
                                    const Text(
                                      "Sign In with Google",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Does not have account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const screen_registration()));
                                },
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink),
                                ),
                              ),
                            ],
                          )
                          //button - login with google--call function _handleSignIn()
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
