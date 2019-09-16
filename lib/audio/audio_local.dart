import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioLocal extends StatefulWidget {

  final File file;

  AudioLocal({this.file});
  
  @override
  _AudioLocalState createState() => _AudioLocalState();
}

class _AudioLocalState extends State<AudioLocal> {
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  bool isStarted = false;
  Duration duration;
  int time;

  String timeLeft = "";
  double progress = 0.0;

  startPlaying() async{
    if(!isStarted) {
      await audioPlayer.play( widget.file.path, isLocal: true);
      isStarted = true;
    }
    else await audioPlayer.resume();
    // time  = await audioPlayer.getDuration();
  }

  getTimeLeft() {
    if(duration == null) {
      setState(() {
       timeLeft = "Time Left 0s"; 
      });
    } else {
      setState(() {
       timeLeft = "Time Left ${duration.inSeconds}s"; 
      });
    }
  }
  getProgress()  {
    if(time == null || duration == null) {
      setState(() {
       progress = 0.0; 
      });
    } else {
      setState(() {
        progress = time / (duration.inMilliseconds);
      });
    }  
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      time = await audioPlayer.getDuration();
        duration = p;
      if(duration == null) {
       timeLeft = "Time Left 0s/0s"; 
    } else {
       timeLeft = "Time Left ${duration.inSeconds}s/${time/1000}s"; 
    }
    if(time == null || duration == null) {
       progress = 0.0; 
    } else {
        progress = (duration.inMilliseconds)/ time ;
    }
    setState(() {
      
    });
    });
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print("$state");
      if (state == AudioPlayerState.PLAYING) {
        setState(() {
          isPlaying = true;
        });
      } else {
        if(mounted) {
          setState(() {
            isPlaying = false;
          });
        }
      }
    });
  }

  @override
  void dispose() async {
    await audioPlayer.release();
    await audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                value: progress,
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(timeLeft),
              SizedBox(
                height: 16.0,
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    isPlaying ? audioPlayer.pause() : startPlaying();
                    setState(() {});
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
