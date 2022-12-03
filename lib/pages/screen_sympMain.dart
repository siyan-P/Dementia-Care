import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/API/HTTPhelper.dart';
import 'package:http/src/response.dart';

class screen_sympMain extends StatefulWidget {
  screen_sympMain(this.itemId, {Key? key}) : super(key: key) {
    _futurePost = HTTPhelper().getItem(itemId);
  }
  String itemId;
  late Future<Map> _futurePost;

  @override
  State<screen_sympMain> createState() => _screen_sympMainState();
}

class _screen_sympMainState extends State<screen_sympMain> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();
  late Map post;

  intiState() {
    super.initState();
    _controllerTitle.text = post['title'];
    _controllerBody.text = post['body'];
  }

  //-->update the symptom-->open bottom sheet
  Future<void> BottomSheet(BuildContext ctx) async {
    print('controller value is ${_controllerTitle.text}');
    showModalBottomSheet(
        backgroundColor: Colors.white,
        barrierColor: Colors.transparent,
        context: ctx,
        builder: (_) {
          return Container(
            height: 570,
            decoration: BoxDecoration(
                color: const Color(0xFF2e3253).withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('please enter your updated symtom details'),
                  TextFormField(
                    controller: _controllerTitle,
                  ),
                  TextFormField(
                    controller: _controllerBody,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            //updated dato to be passed to the HTTP helpre class
                            Map<String, String> dataToUpdate = {
                              'title': _controllerTitle.text,
                              'body': _controllerBody.text,
                            };
                            bool status = await HTTPhelper().updateItem(
                                dataToUpdate, post['id'].toString());
                            if (status) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Succssfully updated!')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Faild to update!')));
                            }
                            Navigator.pop(ctx);
                          },
                          child: const Text('update')),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('Cancel'))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  //deleting the listed item,
                  bool deleted = await HTTPhelper().deleteItem(widget.itemId);
                  if (deleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post deleted')));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('faild to delete ${widget.itemId}')));
                  }
                },
                icon: const Icon(Icons.delete_forever))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //update the current data
            BottomSheet(context);
          },
          child: const Icon(Icons.update),
        ),
        body: Column(
          children: [
            FutureBuilder<Map>(
                future: widget._futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error!${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    post = snapshot.data!;
                    return Column(
                      children: [
                        Text(
                          '${post['title']}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '${post['body']}',
                            style: const TextStyle(
                                fontSize: 15, fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ));
  }
}
