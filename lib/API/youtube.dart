import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_4/consts/constands.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class youtubeVideo extends StatefulWidget {
  const youtubeVideo({Key? key}) : super(key: key);

  @override
  State<youtubeVideo> createState() => _youtubeVideoState();
}

class _youtubeVideoState extends State<youtubeVideo> {
  String vidUrl = "https://www.youtube.com/watch?v=nLdLfmFzLSo";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    final vidID = YoutubePlayer.convertUrlToId(vidUrl);
    _controller = YoutubePlayerController(
        initialVideoId: vidID!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Dementia Care",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            verticalspace(25),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
