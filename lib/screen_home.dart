import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class screen_home extends StatelessWidget {
  //screen_home(Map<String, dynamic>? userData, AccessToken? accessToken, {Key? key}) : super(key: key);
  //accessing passed data -- accessToken and userdata:
  screen_home(this._userData, this.accessToken,{Key? key}) : super(key: key);
  Map<String, dynamic>? _userData;
  AccessToken? accessToken;
  //login with google-data receving
  GoogleSignInAccount? user;
  String _contactText = '';
  // bool _checking = true;
  //checking accessToken is recived or not:

  // void access() {
  //   print("clikedddd event");
  //   if (accessToken != null) {
  //     print("cliked event");
  //     print(accessToken!.userId);
  //     print("is Logged:::: ${prettyPrint(accessToken!.toJson())}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text("home page"),
            //  Text("is Logged:::: ${prettyPrint(accessToken!.toJson())}"),
            // Text("home page"),
            //access token value == null; we have to pass the value of accessToken
            //display the info- of current user login--email,name and profile 
            accessToken != null
                ? Text(_userData!['email'])
                : Text("NO AccessToken Found!"),
            accessToken != null ? Text(_userData!['name']) : Container(),
            accessToken != null
                ? Image.network(_userData?['picture']['data']['url'])
                : Container(),

            ElevatedButton.icon(
                onPressed: () {
                  //facebook logout
                   _logOut(context);
              
                },
                icon: Icon(Icons.exit_to_app),
                label: Text("logout")),
          ],
        ),
      ),
    )));
  }

  Future<void> _logOut(ctx) async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    _userData = null;
    // setState(() {});
    Navigator.pop(ctx);
        
  }
}
