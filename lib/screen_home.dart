import 'package:flutter/material.dart';
import 'package:flutter_application_4/consts/constands.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/pages/screen_symptoms.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_application_4/consts/constands.dart';

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
        backgroundColor: color.myColorS,
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
              color: color.myColorS,
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
                color: Colors.black,
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
                color: Colors.black,
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
            const SizedBox(
              height: 280,
            ),

            ElevatedButton.icon(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.white)))),
                onPressed: () {
                  _logOut(context);
                },
                icon: const Icon(Icons.logout_rounded),
                label: const Text("LogOut")),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              //  width: 500,
              // height: 250,
              // color:Colors.blue,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(60)),
                color: color.myColorS,
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
                            image: NetworkImage(
                                _userData?['picture']['data']['url']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Hello ' ",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                        accessToken != null
                            ? Text(
                                _userData!['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
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
                              ? Text(
                                  _userData!['email'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              : Text("NO AccessToken Found!"),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "“The cheerful mind perseveres, and the strong mind hews its way through a thousand difficulties.” ",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   color: Colors.amberAccent,
                    //   width: 200,
                    //   height: 200

                    //   ,
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 100,
                // color: Colors.cyan,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(30),
                        bottomEnd: Radius.circular(30)),
                    color: Colors.blueGrey),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("About'"),
                      Text(
                        "This patient also had an additional risk factor for AD, being a heterozygote for the apoЄ4 allele. Among other mechanisms, its presence reduces clearance of Aβ42 from the brain and increases glial activation",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  //  color: Colors.lightBlue,
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: color.myColorS,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        const Text(
                          "Hi..How Do you feel Today",
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                iconSize: 41,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: Text('Feeling veryGood!'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                    Icons
                                                        .sentiment_very_satisfied_outlined,
                                                    size: 33),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  //  height: 20,
                                                  //  color: color.myColor,
                                                  child:
                                                      const SingleChildScrollView(
                                                    child: Text(
                                                        "Well, relax, because there are plenty of warm, hopeful, encouraging and"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            ElevatedButton(
                                                child: Text("Done"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(
                                    Icons.sentiment_very_satisfied_outlined)),
                            IconButton(
                                iconSize: 41,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text('Feeling Good!'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                const Icon(
                                                    Icons
                                                        .sentiment_satisfied_outlined,
                                                    size: 33),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  //  height: 20,
                                                  //  color: color.myColor,
                                                  child:
                                                      const SingleChildScrollView(
                                                    child: Text(
                                                        "Well, relax, because there are plenty of warm, hopeful, encouraging and"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            ElevatedButton(
                                                child: Text("Done"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(Icons.sentiment_satisfied_outlined)),
                            IconButton(
                                iconSize: 41,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: Text('Feeling Nothing!'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                    Icons
                                                        .sentiment_neutral_outlined,
                                                    size: 33),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  //  height: 20,
                                                  //  color: color.myColor,
                                                  child:
                                                      const SingleChildScrollView(
                                                    child: Text(
                                                        "Well, relax, because there are plenty of warm, hopeful, encouraging and"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            ElevatedButton(
                                                child: Text("Done"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.sentiment_neutral_outlined)),
                            IconButton(
                                iconSize: 41,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text('Feeling bad!'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                 const Icon(
                                                    Icons
                                                        .sentiment_dissatisfied_outlined,
                                                    size: 33),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  //  height: 20,
                                                  //  color: color.myColor,
                                                  child:
                                                      const SingleChildScrollView(
                                                    child: Text(
                                                        "Well, relax, because there are plenty of warm, hopeful, encouraging and"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            ElevatedButton(
                                                child: Text("Done"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        );
                                      });
                                },
                                icon:
                                    Icon(Icons.sentiment_dissatisfied_rounded)),
                            IconButton(
                                iconSize: 41,
                                highlightColor: Colors.yellowAccent,
                                onPressed: () {
                                  print("button cliked!");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text('Feeling veryBad!'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                const Icon(
                                                    Icons
                                                        .sentiment_very_dissatisfied_outlined,
                                                    size: 33),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  //  height: 20,
                                                  //  color: color.myColor,
                                                  child:
                                                      const SingleChildScrollView(
                                                    child: Text(
                                                        "Well, relax, because there are plenty of warm, hopeful, encouraging and"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            ElevatedButton(
                                                child: Text("Done"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(Icons
                                    .sentiment_very_dissatisfied_outlined)),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                //  height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: color.myColorS,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          child: const Text(
                            'Access My Symptoms',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const screen_symptoms()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: color.myColor, // Background color
                          )),
                      ElevatedButton(
                          child: const Text('Post a health Qustion',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: color.myColor, // Background color
                          )),
                      ElevatedButton(
                          child: const Text('Entroll in a Care guide',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: color.myColor, // Background color
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
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
