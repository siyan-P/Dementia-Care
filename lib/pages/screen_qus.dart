import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/API/HTTPhelper.dart';
import 'package:flutter_application_4/API/youtube.dart';
import 'package:flutter_application_4/consts/constands.dart';
import 'package:flutter_application_4/pages/screen_splash.dart';
import 'package:flutter_application_4/pages/screen_sympMain.dart';

class screen_qus extends StatefulWidget {
  screen_qus({Key? key}) : super(key: key);
  //final url;
  @override
  State<screen_qus> createState() => _screen_qusState();
}

class _screen_qusState extends State<screen_qus> {
  // YoutubePlayerController? _controller;

  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  Future<List<Map>> _futurepost = HTTPhelper().fetchItems(SAVE_KEY_NAME);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

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
                MaterialPageRoute(builder: (context) => screen_sympMain(null)));
          },
          child: const Icon(Icons.next_plan),
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
                            builder: (context) => const youtubeVideo()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        //shadowColor: Colors.pinkAccent,
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.blueGrey.shade100,
                            Colors.grey.shade200
                          ])),
                          child: Column(
                            children: [
                              // Text("Dementia Care"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      '${thisItem['title']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  subtitle: Text(
                                      '${thisItem['description']}A person with dementia might become agitated when once-simple tasks become difficult. To limit challenges and ease frustration'),
                                ),
                              ),
                              verticalspace(15),
                              const Text('for more,Click -->video lectures'),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
