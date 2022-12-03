import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/API/HTTPhelper.dart';
import 'package:flutter_application_4/pages/screen_AddPost.dart';
import 'package:flutter_application_4/pages/screen_sympMain.dart';
import 'package:http/http.dart';

class screen_qus extends StatelessWidget {
  screen_qus({Key? key}) : super(key: key);

  Future<List<Map>> _futurepost = HTTPhelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Access Symptoms'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => screen_AddPost()));
          },
          child: const Icon(Icons.add_chart),
        ),
        body: FutureBuilder<List<Map>>(
          future: _futurepost,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error! ${snapshot.error}');
            }
            if (snapshot.hasData) {
              List<Map> posts = snapshot.data;
              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    Map thisItem = posts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                screen_sympMain(thisItem['id'].toString())));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text('${thisItem['title']}'),
                          subtitle: Text('${thisItem['body']}'),
                        ),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
