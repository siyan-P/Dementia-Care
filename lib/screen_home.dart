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
  screen_home(this._userData, this.accessToken, {Key? key}) : super(key: key);
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
      appBar: AppBar(
        title: Text(
          "Dementia Care",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.blueAccent,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 30, bottom: 27),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              _userData?['picture']['data']['url']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      _userData!['email'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(_userData!['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white))
                  ],
                ),
              ),
            ),
            // Text("sample"),
            const ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Profile ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.settings_accessibility_outlined,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Settings ",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: null,
              focusColor: Colors.redAccent,
              selectedTileColor: Colors.redAccent,
            ),
            SizedBox(
              height: 280,
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)))),
                onPressed: () {
                  //logout --by login with facebook
                  _logOut(context);
                },
                icon: Icon(Icons.logout),
                label: Text("LogOut")),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        //  width: 500,
        height: 250,
        // color:Colors.blue,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
          color: Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 220, top: 15),
                child: Container(
                  //  padding: EdgeInsets.all(30),
                  width: 70,
                  height: 70,
                  // margin: const EdgeInsets.only(top: 30, bottom: 27),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(_userData?['picture']['data']['url']),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Text(
                    "Hello ' ",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.lightBlueAccent),
                  ),
                   accessToken != null
                    ? Text(_userData!['name'] ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
                    : Text("NO AccessToken Found!"),
                  //  accessToken != null
                  //   ? Text(_userData!['email'] ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),)
                  //   : Text("NO AccessToken Found!"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.start,
                //  crossAxisAlignment: CrossAxisAlignment.start,
                
                  children: [
                    
                     accessToken != null
                      ? Text(_userData!['email'] ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)
                      : Text("NO AccessToken Found!"),
                      SizedBox(height: 20,),
                    Text("“The cheerful mind perseveres, and the strong mind hews its way through a thousand difficulties.” ",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.lightBlueAccent),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      
      ),
    );
  }

  Future<void> _logOut(ctx) async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    _userData = null;
    // setState(() {});
    //  Navigator.pop(ctx);
    Navigator.of(ctx).popUntil((route) => route.isFirst);
  }
}
