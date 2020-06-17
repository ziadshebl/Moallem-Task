import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {

  //Setting a route name for the screen for easy access
  static const routeName = '/video_screen';
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //Initializing the video controller
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    //Enabling the looping
    _controller.setLooping(true);
  }


  //Disposing the video controller to avoid memory leakage
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        appBar: AppBar(backgroundColor: Colors.green,),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
    );
  }
}
