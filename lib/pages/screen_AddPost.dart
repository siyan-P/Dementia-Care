import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/API/HTTPhelper.dart';
import 'package:flutter_application_4/consts/constands.dart';

class screen_AddPost extends StatefulWidget {
  const screen_AddPost({Key? key}) : super(key: key);

  @override
  State<screen_AddPost> createState() => _screen_AddPostState();
}

class _screen_AddPostState extends State<screen_AddPost> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Symptom'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Add Your Title'),
              controller: _controllerTitle,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Add Description'),
              controller: _controllerBody,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      Map<String, String> dataToAdd = {
                        'title': _controllerTitle.text,
                        'body': _controllerBody.text,
                      };
                      bool status = await HTTPhelper().addItem(dataToAdd);
                      if (status) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Succssfully Added!')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('faild to add post!')));
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Submit')),
                horizontalspace(10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel')),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
