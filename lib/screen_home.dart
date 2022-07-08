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
  screen_home(this._userData, this.accessToken, this.user) ;
  
  void checking(){
    if(_userData  == null){
      // GoogleSignInAccount? user;
      // String _contactText = '';
      // GoogleSignIn _googleSignIn = GoogleSignIn();
  }
  else{
    Map<String, dynamic>? _userData;
  AccessToken? accessToken;
  //login with google-data receving
  GoogleSignInAccount? user;
  String _contactText = '';
  }
  }
  Map<String, dynamic>? _userData;
  AccessToken? accessToken;
  //login with google-data receving
  GoogleSignInAccount? user;
  String _contactText = '';
  GoogleSignIn _googleSignIn = GoogleSignIn();
  //google-info
    // GoogleSignInAccount? _user;
    // String contactText = '';
    // GoogleSignIn _googleSignIn = GoogleSignIn();
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
    print("in home page");
    if(_userData != null){
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
  else{
  
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
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     // image: DecorationImage(
                    //     //   image: NetworkImage(
                    //     //     //  _userData?['picture']['data']['url']),
                    //     //     ,
                    //     //   fit: BoxFit.fill,
                    //     // ),
                    //  //   image: NetworkImage('data:image/png;base64,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'),
                        
                    //   ),
                    
                    ),
                    Text(user!.email,
                  //    _userData!['email'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    // Text(_userData!['name'],
                    //     style: const TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 15,
                    //         color: Colors.white))
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
                  _handleSignOut(context);
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
                      // child: Container(
                      //   //  padding: EdgeInsets.all(30),
                      //   width: 70,
                      //   height: 70,
                      //   // margin: const EdgeInsets.only(top: 30, bottom: 27),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: NetworkImage(
                      //           _userData?['picture']['data']['url']),
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      // ),
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
                     //   accessToken != null
                    //  user!= null ?
                             Text("msp palakkal",
                               // user!.email,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                          //   Text("NO AccessToken Found!"),
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
                    user!= null ?
                             Text(
                                user!.email,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ):
                             Text("NO AccessToken Found!"),
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
  }

  Future<void> _logOut(ctx) async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    _userData = null;
    // setState(() {});
    //  Navigator.pop(ctx);
    Navigator.of(ctx).popUntil((route) => route.isFirst);
  }

   Future<void> _handleSignOut(contex) async {
    _googleSignIn.disconnect();
   // Navigator.pop(contex);
   Navigator.of(contex).popUntil((route) => route.isFirst);
  }
}
