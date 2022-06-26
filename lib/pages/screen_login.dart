import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/googledemo.dart';
import 'package:flutter_application_4/pages/screen_registration.dart';
import 'package:flutter_application_4/sample.dart';
import 'package:flutter_application_4/screen_home.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class screen_login extends StatefulWidget {
  const screen_login({Key? key}) : super(key: key);

  @override
  State<screen_login> createState() => _screen_loginState();
}

class _screen_loginState extends State<screen_login> {
  //facebook
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  //google
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  //google
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
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
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    // print(_currentUser!.email);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => sample(_currentUser)));
  }

  // google account signOut
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

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
              builder: (context) => screen_home(
                    userData,
                    accessToken,
                    
                  )));
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }

  //facebook-logout
  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
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
                    child: Stack(
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  "images/dementia_login_whi.png",
                                  height: 150,
                                )),
                            const Text(
                              "Welcome Back!",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Image.asset(
                              "images/login.jpg",
                              height: 120,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                  left: 28, right: 28, bottom: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  // errorBorder:
                                  border: OutlineInputBorder(),
                                  hintText: 'eg: octavia@123',
                                  labelText: 'user name',
                                  fillColor: Colors.grey,
                                  prefixIcon:
                                      Icon(Icons.person_pin_circle_outlined),
                                  suffixIconColor: Colors.blue,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(left: 28, right: 28),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  // errorBorder:
                                  border: OutlineInputBorder(),
                                  hintText: 'octavia',
                                  labelText: 'Password',
                                  fillColor: Colors.grey,
                                  prefixIcon: Icon(Icons.password),
                                  suffixIconColor: Colors.blue,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forgott Password?'),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.white)))),
                                onPressed: () {
                                  //normal username pass login -- home page
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => screen_home(
                                               
                                  //             )));
                                },
                                icon: const Icon(Icons.login),
                                label: const Text("Login")),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Or Login with Social media"),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.white)))),
                                    onPressed: () {
                                      _login();
                                      // _checkIfIsLogged();
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => screen_home(_userData)));
                                    },
                                    child: const Text("facebook")),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.white)))),
                                    onPressed: () {
                                      _handleSignIn();
                                    },
                                    child: const Text("Google")),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Does not have account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => screen_registration()));
                                  },
                                  child: const Text(
                                    'SignUp',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                            //button - login with google--call function _handleSignIn()

                            // ElevatedButton(
                            //     onPressed: () {
                            //       _handleSignOut();
                            //     },
                            //     child: const Text("out")),
                            //   ElevatedButton(onPressed: (){
                            //  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInDemo()));
                            //  }, child: const Text("google demo")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
