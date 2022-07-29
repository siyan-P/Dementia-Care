import 'package:flutter/material.dart';
import 'package:flutter_application_4/local_db/db_functions.dart';

class screen_sympMain extends StatelessWidget {
  const screen_sympMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.warning_amber_rounded),
                Text("Page under constraction!"),
                ElevatedButton(onPressed: (){ altertabel();}, child: Text("date and time"))
              ],
            ),
          )
          ));
    
  }
}
void dateandtime(){
DateTime now = DateTime.now();
print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
//String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
String datetime = DateTime.now().toString();
print(datetime);
var dt = DateTime.now();
//print(dt.day); //displaying current date like 22,23,24...
if(dt.day == dt.day)
{
  print('not current date...or not the time to acceept!');

}else{
  print(dt.day);
}
}

