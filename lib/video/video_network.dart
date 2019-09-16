import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoNetwork extends StatefulWidget {
  @override
  _VideoNetworkState createState() => _VideoNetworkState();
}

class _VideoNetworkState extends State<VideoNetwork> {
  VideoPlayerController _videoPlayerController = VideoPlayerController.network(
      "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4",);

  @override
  void initState() {
    super.initState();
    _videoPlayerController
      ..initialize().then((_) {
        _videoPlayerController.setLooping(true);
        setState(() {});
      });
    _videoPlayerController..addListener(() {
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video From Network"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _videoPlayerController.value.initialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Container(),
            Center(
              child: IconButton(
                icon: Icon(
                  _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: () {
                   _videoPlayerController.value.isPlaying ? _videoPlayerController.pause() : _videoPlayerController.play();
                   setState(() {
                     
                   });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
