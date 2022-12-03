import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class screen_signOutFacebook extends StatelessWidget {
  const screen_signOutFacebook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // primary: false,
        drawerScrimColor: Colors.pink.shade700,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Icon(Icons.warning_amber_rounded),
              Text("Do you wants to exit"),
              ElevatedButton(onPressed: () {}, child: Text("logOut"))
            ],
          ),
        )));
  }

//    Future<void> _logOut(ctx) async {
//     await FacebookAuth.instance.logOut();
//      accessToken = null;
//     _userData = null;
//     // setState(() {
//     //   // accessToken = null;
//     //   // _userData = null;
//     // });
//     //  Navigator.pop(ctx);
//     Navigator.of(ctx).popUntil((route) => route.isFirst);
//   }
}
