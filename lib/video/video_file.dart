import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoFile extends StatefulWidget {

  VideoFile({this.file});

  final File file;
  
  @override
  _VideoFileState createState() => _VideoFileState();
}

class _VideoFileState extends State<VideoFile> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.file,);
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
        child: SingleChildScrollView(
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
      ),
    );
  }
}
