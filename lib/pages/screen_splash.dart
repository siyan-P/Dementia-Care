import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_login.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';

class screen_splash extends StatefulWidget {
  const screen_splash({Key? key}) : super(key: key);

  @override
  State<screen_splash> createState() => _screen_splashState();
}

class _screen_splashState extends State<screen_splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "images/dementia_login_whi.png",
                        height: 200,
                      )),
                  const Text(
                    "Dementia\n Health Care",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Image.asset(
                    "images/wecome.jpg",
                    height: 180,
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                   //   notify();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const screen_login(),
                          ));
                    },
                    icon: const Icon(Icons.follow_the_signs_rounded),
                    label: const Text("Gets Start!"),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    side: BorderSide(color: Colors.white)))),
                  ),
                  //    ElevatedButton.icon(
                  // style: ElevatedButton.styleFrom(primary: Colors.cyan,),
                  // onPressed: () {
                  //   //logout --by login with facebook
                  // //  _logOut(context);
                  // },
                  // icon: Icon(Icons.logout),
                  // label: Text("LogOut")),
                ],
              )),
        ));
  }
  //fun used to display notifications--using awesome notification
//   void notify() async{
//      String timezom = await AwesomeNotifications().getLocalTimeZoneIdentifier(); //get time zone you are in

// AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 1,
//         channelKey: 'key1',
//         title: 'This is Notification title',
//         body: 'This is Body of Noti',
//      //   bigPicture: 'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
//      //   notificationLayout: NotificationLayout.BigPicture
//       ),
//    schedule: NotificationInterval(interval: 2,timeZone: timezom,repeats: true),
//   );
//   }
}
