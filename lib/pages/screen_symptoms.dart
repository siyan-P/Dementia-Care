import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_sympMain.dart';
import 'package:flutter_application_4/services/remote_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_4/API/Models_symp.dart';

class screen_symptoms extends StatefulWidget {
  const screen_symptoms({Key? key}) : super(key: key);

  @override
  State<screen_symptoms> createState() => _screen_symptomsState();
}

//int number = 1;
//TextEditingController _textFieldController = TextEditingController();
//TextEditingController _descriptionController = TextEditingController();

class _screen_symptomsState extends State<screen_symptoms> {
  List<Post>? posts;
  var isLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch data from api
    getData();
  }

  getData() async {
    posts = await RemoteServices().getPost();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> BottomSheet(BuildContext ctx) async {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        barrierColor: Colors.transparent,
        context: context,
        builder: (_) {
          return Container(
            height: 570,
            decoration: BoxDecoration(
                color: const Color(0xFF2e3253).withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('posts!.id.toString()'),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                      label: const Text('Close'))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // print("passing data from ${posts!.id}");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            "Dementia Care",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
        ),
        //add futureBuilder method for loading datas from api
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              // physics: const ScrollPhysics(parent: null),
              shrinkWrap: true,
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => screen_sympMain(),
                    //         settings:
                    //             RouteSettings(arguments: posts![index].id)));
                    BottomSheet(context);
                  },
                  child: Card(
                      child: ListTile(
                          title: Text(posts![index].id.toString()),
                          //  title: Text(),
                          subtitle: Text(posts![index].title),
                          //  leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     snapshot.data?[index]['image'])),
                          trailing: const Icon(Icons.next_plan_outlined))),
                );
              }),
          replacement: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Loading...pls Wait few seconds.."),
              ],
            ),
          ),
        ));
  }
}
      
    
  
  

  // late String valueText = 'msp';
  // late String codeDialog = 'des';
  // Future<void> addSymptom(BuildContext ctx) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Add a Symptom'),
  //           content: Padding(
  //             padding: const EdgeInsets.all(5),
  //             child: SizedBox(
  //               width: MediaQuery.of(context).size.width,
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     TextField(
  //                       onChanged: (value) {
  //                         setState(() {
  //                           valueText = value;
  //                         });
  //                       },
  //                       controller: _textFieldController,
  //                       decoration: const InputDecoration(
  //                           hintText: "pls enter name of symptom"),
  //                     ),
  //                     TextField(
  //                       onChanged: (value) {
  //                         setState(() {
  //                           codeDialog = value;
  //                         });
  //                       },
  //                       controller: _descriptionController,
  //                       decoration: const InputDecoration(
  //                           hintText: "Describe some Descriptions about it"),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               child: const Text('Cancel'),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //             ElevatedButton(
  //               child: const Text('Submit'),
  //               onPressed: () {
  //                 setState(() {
  //                   // codeDialog = valueText;
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }
 

  



