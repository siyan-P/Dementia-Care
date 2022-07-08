import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class sample extends StatelessWidget {
  sample(this.user, { Key? key }) ;

  GoogleSignInAccount? user;
  String _contactText = '';
  GoogleSignIn _googleSignIn = GoogleSignIn();

    test(){
    print("button cliked");
    print(user?.email);
   if(user != null){
     print(user!.email);
   }
  }

  Future<void> _handleSignOut(ctx) async {
    _googleSignIn.disconnect();
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          children: [
            const Text("HOME PAGE"),
           //  ListTile(
            // leading: GoogleUserCircleAvatar(
            //   identity:user,
            // ),
        //    title: Text(user!.displayName ?? ''),
         //   subtitle: Text(user!.email),
       //   ),
          // if(user != null){
          //   Text(user!.email),
          // },
         ElevatedButton(onPressed: (){
          // Future<void> _handleSignOut() => _googleSignIn.disconnect();
           test();
         }, child: Text("data")),
       //  user != null ?Text(user!.email) : Container(),
       //  Text(user!.email),
        // Text(user!.displayName ?? ''),
         ElevatedButton(onPressed: (){
           _handleSignOut(context);
         }, child: Text("LogOut")),
          ],
        ),
      )),
      
    );
  }
}