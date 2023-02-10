import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/consts/constands.dart';
import 'package:flutter_application_4/local_db/db_functions.dart';
import 'package:flutter_application_4/pages/MyLocation.dart';
import 'package:flutter_application_4/pages/screeen_about.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
import 'package:flutter_application_4/pages/screen_qus.dart';
import 'package:flutter_application_4/pages/screen_splash.dart';
import 'package:flutter_application_4/pages/screen_symptoms.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_application_4/consts/constands.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class screen_home extends StatefulWidget {
  var email;

  screen_home(this.userData, this.accessToken, this.user, this.email);
  var dt = DateTime.now();

  Map<String, dynamic>? userData;
  AccessToken? accessToken;
  //login with google-data receving
  GoogleSignInAccount? user;
  String _contactText = '';
  //userInfo email;
  @override
  State<screen_home> createState() => _screen_homeState();
}

class _screen_homeState extends State<screen_home> {
  static const myColor = Colors.pinkAccent;
  static const myColors = Colors.pinkAccent;
  bool isClicked = true;
  var dt = DateTime.now();

  String? name;
  // var today = dt.da
  //screen_home(Map<String, dynamic>? userData, AccessToken? accessToken, {Key? key}) : super(key: key);
  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  void checking() {
    if (widget.userData == null) {
      // GoogleSignInAccount? user;
      // String _contactText = '';
      // GoogleSignIn _googleSignIn = GoogleSignIn();
    } else {
      Map<String, dynamic>? _userData;
      AccessToken? accessToken;
      //login with google-data receving
      GoogleSignInAccount? user;
      String _contactText = '';
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //function to display current date and time
  void datecheking() {
    var dt = DateTime.now();
    //print(dt.day);
    var today = dt.day;
  }

  _launchURL() async {
    const url =
        'https://www.nursingtimes.net/clinical-archive/neurology/enhancing-healthcare-assistants-dementia-role-23-02-2015/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //through facebook login-info
  @override
  Widget build(BuildContext context) {
    if (widget.userData != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
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
                padding: const EdgeInsets.all(20),
                color: myColor,
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
                                widget.userData?['picture']['data']['url']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        widget.userData!['email'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(widget.userData!['name'],
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

              verticalspace(280),
              const Text("LOGOUT"),
              IconButton(
                onPressed: () {
                  _logOut(context);
                },
                icon: const Icon(Icons.logout_outlined),
                color: Colors.pink.shade700,
                iconSize: 28,
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(30, 35),
                      bottomLeft: Radius.elliptical(30, 35)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10), //lfirst container
                  child: Column(
                    children: [
                      Image.asset(
                        "images/Dementia-1-removebg-preview.jpg",
                        height: 160,
                      ),
                      verticalspace(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Welcome ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          widget.accessToken != null
                              ? Text(
                                  widget.userData!['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink.shade700),
                                )
                              : const Text("No Named!"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(12),
                          topEnd: Radius.circular(12),
                          bottomEnd: Radius.circular(30),
                          bottomStart: Radius.circular(30)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        //-->Scrollable listview
                        const Text("More About me",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: 160,
                                // color: Colors.blueGrey,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LocationPage(),
                                                        ));
                                                  },
                                                  child: Image.network(
                                                    'https://plus.unsplash.com/premium_photo-1658506864415-f79c6ec9f44e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                    horizontalspace(3),
                                    const Text("About ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                              Container(
                                // height: 180,
                                width: 160,

                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //       builder: (context) =>

                                              //     ));
                                            },
                                            child: Image.network(
                                              'https://www.littlenecknursing.com/wp-content/uploads/2020/07/Alzheimer%E2%80%99s-Dementia-Care-.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                        )),
                                    horizontalspace(3),
                                    const Text("my favorites",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                              Container(
                                // height: 180,
                                width: 160,

                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           screen_about(),
                                                    //     ));
                                                  },
                                                  child: Image.network(
                                                    'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                    horizontalspace(3),
                                    const Text(
                                      "medicine",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                              Container(
                                // height: 180,
                                width: 160,

                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           // MyLocation(),
                                                    //           screen_about(),
                                                    //     ));
                                                  },
                                                  child: Image.network(
                                                    'https://plus.unsplash.com/premium_photo-1664444190530-de772e83f7bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1063&q=80',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                    horizontalspace(3),
                                    const Text("more about",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                            ],
                          ),
                        ),

                        //emoji capture--daily route

                        //options panel-->btn for asscess symptoms,posthealt related issues,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //  height: 200,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                      child: const Text(
                                        'Dementia Related Question',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const screen_symptoms()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor,
                                        // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                  ElevatedButton(
                                      child: const Text('Access My Symptoms',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  screen_qus(),
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor, // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                  ElevatedButton(
                                      child: const Text(
                                          'Entroll in a Care guide',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        _launchURL();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor, // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isClicked
                                ? const Text(
                                    'Have a get-together?click,',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.pink),
                                  )
                                : const Text(
                                    'Thanks!..\nSuccessfully updated.',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.pink),
                                  ),
                            IconButton(
                              onPressed: () {
                                bottomSheet(context);
                              },
                              icon: const Icon(Icons.next_plan_outlined),
                              iconSize: 25,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      //page for google login -->under constraction
      //# google login
    }
    if (widget.user != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dementia Care",
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: myColor,
                child: Center(
                  child: Column(
                    children: [
                      //  Container(
                      //  width: 100,
                      //   height: 100,
                      //   margin: const EdgeInsets.only(top: 30, bottom: 27),
                      //   decoration: const BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: NetworkImage(
                      //           "https:www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngitem.com%2Fmiddle%2FhmbJbbw_computer-icons-user-profile-new-user-icon-png%2F&psig=AOvVaw0DT-IcqPVD_eUuc_mYGm7g&ust=1663868751338000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCNiqkfDfp_oCFQAAAAAdAAAAABAD"),
                      //       fit: BoxFit.fill,
                      //     ),
                      //   ),
                      // ),
                      Text(
                        widget.user!.email,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      //  String? widget.user!.displayName;

                      // widget.user!.displayName != null ?
                      // Text(widget.user!.displayName) : const Text("data"),
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
              const Text("LOGOUT"),
              IconButton(
                onPressed: () {
                  _handleSignOut(context);
                },
                icon: const Icon(Icons.logout_outlined),
                color: Colors.pink.shade700,
                iconSize: 28,
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(30, 35),
                      bottomLeft: Radius.elliptical(30, 35)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10), //lfirst container
                  child: Column(
                    children: [
                      Image.asset(
                        "images/Dementia-1-removebg-preview.jpg",
                        height: 160,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          widget.accessToken != null
                              ? Text(
                                  widget.user!.email,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink.shade700),
                                )
                              : const Text("NO AccessTokenFound!"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //  SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 100,
                  // color: Colors.cyan,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(12),
                          topEnd: Radius.circular(12),
                          bottomEnd: Radius.circular(30),
                          bottomStart: Radius.circular(30)),
                      color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "About'",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Patient Name : --\n"
                          "Contact Info : --\n"
                          "Health Status: --\n"
                          "Health Records: --\n"
                          "This patient also had an additional risk factor for AD, Among other mechanisms, its presence reduces the health power!",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink.shade700),
                        ),
                        //emoji capture--daily route
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              //  color: Colors.lightBlue,
                              // height: 150,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: myColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  children: [
                                    //  Text(
                                    //   "Hi..How Do you feel Today",
                                    //   style: TextStyle(
                                    //       fontSize: 15,
                                    //       fontStyle: FontStyle.italic,
                                    //       fontWeight: FontWeight.w300,
                                    //       color: Colors.white),
                                    // ),
                                    isClicked
                                        ? const Text(
                                            'Hy..How do you feel Today? Click one',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          )
                                        : const Text(
                                            'Thanks!..Successfully updated.',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            iconSize: 41,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: const Text(
                                                        'Feeling veryGood!',
                                                        style: const TextStyle(
                                                            color: Colors.pink),
                                                      ),
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Icon(
                                                                Icons
                                                                    .sentiment_very_satisfied_outlined,
                                                                size: 33),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colors
                                                                  .pink
                                                                  .shade700,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                //border radius equal to or more than 50% of width
                                                              ),
                                                            ),
                                                            child: const Text(
                                                                "Cancel"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        //if user clicked ones--disble the btn.and also pass the value to local_db
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .pink.shade700,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              //border radius equal to or more than 50% of width
                                                            ),
                                                          ),
                                                          onPressed: isClicked
                                                              ? () {
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      var dt =
                                                                          DateTime
                                                                              .now();
                                                                      insertData(
                                                                          'Very_Good',
                                                                          dt.day); //also we have to pass current date.
                                                                      isClicked =
                                                                          false;
                                                                    });
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              : null,
                                                          child: const Text(
                                                              "Done"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons
                                                .sentiment_very_satisfied_outlined)),
                                        IconButton(
                                            iconSize: 41,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: const Text(
                                                        'Feeling Good!',
                                                        style: TextStyle(
                                                            color: Colors.pink),
                                                      ),
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Icon(
                                                                Icons
                                                                    .sentiment_satisfied_outlined,
                                                                size: 33),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colors
                                                                  .pink
                                                                  .shade700,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                //border radius equal to or more than 50% of width
                                                              ),
                                                            ),
                                                            child: const Text(
                                                                "Cancel"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .pink.shade700,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              //border radius equal to or more than 50% of width
                                                            ),
                                                          ),
                                                          onPressed: isClicked
                                                              ? () {
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      var dt =
                                                                          DateTime
                                                                              .now();
                                                                      insertData(
                                                                          'Good',
                                                                          dt.day);
                                                                      isClicked =
                                                                          false;
                                                                    });
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              : null,
                                                          child: const Text(
                                                              "Done"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons
                                                .sentiment_satisfied_outlined)),
                                        IconButton(
                                            iconSize: 41,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: Text(
                                                        'Feeling Nothing!',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .pink.shade700),
                                                      ),
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Icon(
                                                                Icons
                                                                    .sentiment_neutral_outlined,
                                                                size: 33),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colors
                                                                  .pink
                                                                  .shade700,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                //border radius equal to or more than 50% of width
                                                              ),
                                                            ),
                                                            child: const Text(
                                                                "Cancel"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .pink.shade700,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              //border radius equal to or more than 50% of width
                                                            ),
                                                          ),
                                                          onPressed: isClicked
                                                              ? () {
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      var dt =
                                                                          DateTime
                                                                              .now();
                                                                      insertData(
                                                                          'Nothing',
                                                                          dt.day);
                                                                      isClicked =
                                                                          false;
                                                                    });
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              : null,
                                                          child: const Text(
                                                              "Done"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons
                                                .sentiment_neutral_outlined)),
                                        IconButton(
                                            iconSize: 41,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: const Text(
                                                        'Feeling bad!',
                                                        style: TextStyle(
                                                            color: Colors.pink),
                                                      ),
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Icon(
                                                                Icons
                                                                    .sentiment_dissatisfied_outlined,
                                                                size: 33),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colors
                                                                  .pink
                                                                  .shade700,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                //border radius equal to or more than 50% of width
                                                              ),
                                                            ),
                                                            child: const Text(
                                                                "Cancel"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .pink.shade700,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              //border radius equal to or more than 50% of width
                                                            ),
                                                          ),
                                                          onPressed: isClicked
                                                              ? () {
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      var dt =
                                                                          DateTime
                                                                              .now();
                                                                      //print(dt.year);
                                                                      insertData(
                                                                          'Bad',
                                                                          dt.day);
                                                                      isClicked =
                                                                          false;
                                                                    });
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              : null,
                                                          child: const Text(
                                                              "Done"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons
                                                .sentiment_dissatisfied_rounded)),
                                        IconButton(
                                            iconSize: 41,
                                            highlightColor: Colors.yellowAccent,
                                            onPressed: () {
                                              print("button cliked!");
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      scrollable: true,
                                                      title: const Text(
                                                        'Feeling veryBad!',
                                                        style: TextStyle(
                                                            color: Colors.pink),
                                                      ),
                                                      content: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            const Icon(
                                                                Icons
                                                                    .sentiment_very_dissatisfied_outlined,
                                                                size: 33),
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
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
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colors
                                                                  .pink
                                                                  .shade700,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                //border radius equal to or more than 50% of width
                                                              ),
                                                            ),
                                                            child: const Text(
                                                                "Cancel"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .pink.shade700,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              //border radius equal to or more than 50% of width
                                                            ),
                                                          ),
                                                          onPressed: isClicked
                                                              ? () {
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      //  var dt = DateTime.now();
                                                                      insertData(
                                                                          'very_Bad',
                                                                          dt.day);
                                                                      isClicked =
                                                                          false;
                                                                    });
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              : null,
                                                          child: const Text(
                                                              "Done"),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(Icons
                                                .sentiment_very_dissatisfied_outlined)),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        //options panel-->btn for asscess symptoms,posthealt related issues,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //  height: 200,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                      child: const Text(
                                        'Dementia Related Question',
                                        style: TextStyle(color: Colors.white60),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const screen_symptoms()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor,
                                        // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                  ElevatedButton(
                                      child: const Text('Access My Symptoms',
                                          style:
                                              TextStyle(color: Colors.white60)),
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor, // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                  ElevatedButton(
                                      child: const Text(
                                          'Entroll in a Care guide',
                                          style:
                                              TextStyle(color: Colors.white60)),
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor, // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // retrun page for login with username and password!
    else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
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
                padding: const EdgeInsets.all(20),
                color: myColor,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 30, bottom: 27),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   image: NetworkImage(
                          //       widget.userData?['picture']['data']['url']),
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                      Text(
                        widget.email,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(widget.email,
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

              verticalspace(280),
              const Text("LOGOUT"),
              IconButton(
                onPressed: () {
                  _logoutUser(context);
                },
                icon: const Icon(Icons.logout_outlined),
                color: Colors.pink.shade700,
                iconSize: 28,
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(30, 35),
                      bottomLeft: Radius.elliptical(30, 35)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10), //lfirst container
                  child: Column(
                    children: [
                      Image.asset(
                        "images/Dementia-1-removebg-preview.jpg",
                        height: 160,
                      ),
                      verticalspace(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Welcome ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          widget.email != null
                              ? Text(
                                  widget.email,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink.shade700),
                                )
                              : const Text("No Named!"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(12),
                          topEnd: Radius.circular(12),
                          bottomEnd: Radius.circular(30),
                          bottomStart: Radius.circular(30)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        //-->Scrollable listview
                        const Text("More About me",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: 160,
                                // color: Colors.blueGrey,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LocationPage(),
                                                        ));
                                                  },
                                                  child: Image.network(
                                                    'https://plus.unsplash.com/premium_photo-1658506864415-f79c6ec9f44e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2069&q=80',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                    horizontalspace(3),
                                    const Text("About ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                              Container(
                                // height: 180,
                                width: 160,

                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //       builder: (context) =>

                                              //     ));
                                            },
                                            child: Image.network(
                                              'https://www.littlenecknursing.com/wp-content/uploads/2020/07/Alzheimer%E2%80%99s-Dementia-Care-.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                        )),
                                    horizontalspace(3),
                                    const Text("my favorites",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                              Container(
                                // height: 180,
                                width: 160,

                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           screen_about(),
                                                    //     ));
                                                  },
                                                  child: Image.network(
                                                    'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                    horizontalspace(3),
                                    const Text(
                                      "medicine",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                              Container(
                                // height: 180,
                                width: 160,

                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Material(
                                              child: InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           // MyLocation(),
                                                    //           screen_about(),
                                                    //     ));
                                                  },
                                                  child: Image.network(
                                                    'https://plus.unsplash.com/premium_photo-1664444190530-de772e83f7bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1063&q=80',
                                                    fit: BoxFit.cover,
                                                  ))),
                                        )),
                                    horizontalspace(3),
                                    const Text("more about",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              horizontalspace(10),
                            ],
                          ),
                        ),

                        //emoji capture--daily route

                        //options panel-->btn for asscess symptoms,posthealt related issues,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //  height: 200,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                      child: const Text(
                                        'Dementia Related Question',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const screen_symptoms()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor,
                                        // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                  ElevatedButton(
                                      child: const Text('Access My Symptoms',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  screen_qus(),
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor, // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                  ElevatedButton(
                                      child: const Text(
                                          'Entroll in a Care guide',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        _launchURL();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: myColor, // Background color
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isClicked
                                ? const Text(
                                    'Have a get-together?click,',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.pink),
                                  )
                                : const Text(
                                    'Thanks!..\nSuccessfully updated.',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.pink),
                                  ),
                            IconButton(
                              onPressed: () {
                                bottomSheet(context);
                              },
                              icon: const Icon(Icons.next_plan_outlined),
                              iconSize: 25,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  //--> logout (username and password),

  Future<void> _logoutUser(ctx) async {
    Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();
    //await _sharedPref.whenComplete(() => null);
    // await _sharedPref.
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Navigator.of(ctx).popUntil((route) => route.isFirst);
  }
  //-->facebook logout & return back to first screen!

  Future<void> _logOut(ctx) async {
    await FacebookAuth.instance.logOut();
    widget.accessToken = null;
    widget.userData = null;
    Navigator.of(ctx).popUntil((route) => route.isFirst);
  }

  Future<void> _handleSignOut(contex) async {
    _googleSignIn.disconnect();
    // Navigator.pop(contex);
    Navigator.of(contex).popUntil((route) => route.isFirst);
  }

  //-->bottom sheet for accessing users feeling & emojis,
  void bottomSheet(BuildContext ctx) async {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        barrierColor: Colors.transparent,
        context: ctx,
        builder: (_) {
          return Container(
            height: 400,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 91, 96, 148).withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello..How do you feel today!..\nCan you give a Smile!',
                    style: TextStyle(color: Colors.pink),
                  ),
                  verticalspace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textforemoji("I'm happy-go-lucky"),
                      IconButton(
                        onPressed: isClicked
                            ? () {
                                {
                                  setState(() {
                                    var dt = DateTime.now();
                                    insertData('Very_Good',
                                        dt.day); //also we have to pass current date.
                                    isClicked = false;
                                  });
                                }
                                Navigator.pop(context);
                              }
                            : null,
                        icon:
                            const Icon(Icons.sentiment_very_satisfied_outlined),
                        iconSize: 42,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  textforemojiDetails(
                      "i'm feeling good!,it was an amazing day,thanks for the beatiful moments!"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textforemoji("I'm apathetic"),
                      IconButton(
                        onPressed: isClicked
                            ? () {
                                {
                                  setState(() {
                                    var dt = DateTime.now();
                                    insertData('Nothing',
                                        dt.day); //also we have to pass current date.
                                    isClicked = false;
                                  });
                                }
                                Navigator.pop(context);
                              }
                            : null,
                        icon: const Icon(Icons.sentiment_neutral_outlined),
                        iconSize: 42,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  textforemojiDetails(
                      "i'm feeling Nothing!,it was an sudden for me, thanks for the beatiful moments!"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textforemoji("I'm Despondent!"),
                      IconButton(
                        onPressed: isClicked
                            ? () {
                                {
                                  setState(() {
                                    var dt = DateTime.now();
                                    insertData('Bad',
                                        dt.day); //also we have to pass current date.
                                    isClicked = false;
                                  });
                                }
                                Navigator.pop(context);
                              }
                            : null,
                        icon: const Icon(Icons.sentiment_dissatisfied_outlined),
                        iconSize: 42,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                  textforemojiDetails(
                      "i'm feeling Bod!,it was an sudden for me, i like to improve the sudden things!"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Cancel")),
                ],
              ),
            ),
          );
        });
  }
}
