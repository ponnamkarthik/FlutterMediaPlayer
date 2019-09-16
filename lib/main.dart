import 'dart:io';

import 'package:bootcamp_media_player/audio/audio_local.dart';
import 'package:bootcamp_media_player/audio/audio_network.dart';
import 'package:bootcamp_media_player/video/video_assets.dart';
import 'package:bootcamp_media_player/video/video_file.dart';
import 'package:bootcamp_media_player/video/video_network.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'audio/audio_assets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  _pickVideoFileFrom(context) async {
    File videoFile = await FilePicker.getFile(type: FileType.VIDEO);
    if (videoFile == null) {
      print("Video Picked is null");
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideoFile(
        file: videoFile,
      );
    }));
  }

   _pickAudioFileFrom(context) async {
    File audioFile = await FilePicker.getFile(type: FileType.AUDIO);
    if (audioFile == null) {
      print("Audio Picked is null");
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AudioLocal(
        file: audioFile,
      );
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Player"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Play Video From Internet"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return VideoNetwork();
                }));
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text("Play Video From Assets"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return VideoAssets();
                }));
              },
            ),
             SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text("Play Video From Local"),
              onPressed: () {
                _pickVideoFileFrom(context);
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text("Play Audio From Network"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AudioNetwork();
                }));
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text("Play Audio From Assets"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AudioAssets();
                }));
              },
            ),
            
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text("Play Audio From Local"),
              onPressed: () {
                _pickAudioFileFrom(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
