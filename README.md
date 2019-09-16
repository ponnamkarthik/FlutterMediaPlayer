## Flutter Media PlayBack

Hello All Flutter Devs 

In your daily development you might face the issue with the media playback how to play a remote video or audio any kind of playback issues,

Here we are going to see how to play a `Video` and `Audio` file from Internet, Assets and Local.

In this demo i am going to use three plugins they are

```dart
video_player
audioplayers
file_picker
```

So using this above three plugins we are going to build a demo project for MediaPlayBack

Let's Get Started,

## Dependencies

Add the following dependencies in `pubspec.yaml`

```yaml
video_player: ^0.10.2+1
file_picker: ^1.4.0
audioplayers: ^0.13.2
```

First we see how to play videos then we go for Audios

## Video

Here how to goahead with video

## Permission

Warning: The video player is not functional on iOS simulators. An iOS device must be used during development/testing.

Add the following entry to your Info.plist file, located in <project root>/ios/Runner/Info.plist:
```plist
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

Add below permission in iOS for `file_picker`

```plist
<key>NSAppleMusicUsageDescription</key>
<string>Explain why your app uses music</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Explain why your app uses photo library</string>
```

Ensure the following permission is present in your Android Manifest file, located in <project root>/android/app/src/main/AndroidManifest.xml:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Supported Formats

On iOS, the backing player is AVPlayer. The supported formats vary depending on the version of iOS, AVURLAsset class has audiovisualTypes that you can query for supported av formats.
On Android, the backing player is ExoPlayer, please refer here for list of supported formats.


## Video From Internet

Declare a Variable in your code which a `VideoPlayerController`, this one we are going to use it with `VideoPlayer`

```dart
VideoPlayerController _videoPlayerController = VideoPlayerController.network(
      "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4",);
```

Now to Intialize the Controller call this in `initState`

```dart
  @override
  void initState() {
    super.initState();
    _videoPlayerController
      ..initialize().then((_) {
        setState(() {});
      });
    _videoPlayerController..addListener(() {
      setState(() {
        
      });
    });
  }
```

Now to visualise the Player we need to add the UI code.

```dart
_videoPlayerController.value.initialized
    ? AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: VideoPlayer(_videoPlayerController),
        )
    : Container(),
```

In the above code what we did is, Once the player is initialized we we show the `VideoPlayer` but we are using `AspectRatio` that one is used to autoresize with the video height and width

By default VideoPlayer doesn't provide the controls for use we need to design and handle them by ourselfs

```dart
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
```

here in the above code `_videoPlayerController.play()` will start the video playback `_videoPlayerController.pause()` will pause the player

```dart
@override
void dispose() {
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
    super.dispose();
}
```

Here is the Complete Code for the Video Playback from Internet

```dart
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
```

## Video From Assets

The only major changes between playing a Video from internt and Assets is the `VideoPlayerController` part

```dart
VideoPlayerController _videoPlayerController = VideoPlayerController.asset(
      "assets/video.mp4",);
```

For playing video from assets instead of `VideoPlayerController.network` we use `VideoPlayerController.asset` and remaining all works as above

## Video From File

The only major changes between playing a Video from internt and Local is the `VideoPlayerController` part

```dart
VideoPlayerController _videoPlayerController = VideoPlayerController.file(videoFile);
```

For playing video from Local instead of `VideoPlayerController.network` we use `VideoPlayerController.file` and remaining all works as above

So Inorder to get the file we will use `file_picker` plugin

## Pick a Video File

```dart
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
```
Above code works to pick a file from the Local Storage and passed the file to the New Page where the video will be played

`File videoFile = await FilePicker.getFile(type: FileType.VIDEO);`

this code specified which file type should i get For Video we used `FileType.VIDEO` and For Audio we will user `FileType.AUDIO`


final but important `dispose`

```dart
@override
void dispose() {
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
    super.dispose();
}
```

## Audio

Lets get started with Audio

## AudioPlayer for Remote Files

Intialize Audio Player

```dart
AudioPlayer audioPlayer = AudioPlayer();
```

to start playing a remote file call 

```dart
await audioPlayer.play(
        "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_2MG.mp3");
```

to pasuse or resume

```dart
// pause
audioPlayer.pause();
// resume
await audioPlayer.resume();
```

> Note: This plugin doesn't provide any kind of UI for your player we need to build the UI by ourselfs

In order to listen the player state we need to listen fot the `onPlayerStateChanged`

```dart
audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print("$state");
});
```

In order to listen the player duration updates we need to listen fot the `onPlayerStateChanged`

```dart
audioPlayer.onAudioPositionChanged.listen((Duration p) async {
      print('Current position: $p');
});
```

To get the length of the song use  `audioPlayer.getDuration()`

```dart
await audioPlayer.getDuration();
```

final but important `dispose`

```dart
@override
void dispose() async {
    await audioPlayer.release();
    await audioPlayer.dispose();
    super.dispose();
}
```

Here is the complete AudioPlayer Code - Playing from Internet

```dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioNetwork extends StatefulWidget {
  @override
  _AudioNetworkState createState() => _AudioNetworkState();
}

class _AudioNetworkState extends State<AudioNetwork> {
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  bool isStarted = false;
  Duration duration;
  int time;

  String timeLeft = "";
  double progress = 0.0;

  startPlaying() async {
    if (!isStarted) {
      await audioPlayer.play(
          "https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_2MG.mp3");
      isStarted = true;
    } else
      await audioPlayer.resume();
    // time  = await audioPlayer.getDuration();
  }

  getTimeLeft() {
    if (duration == null) {
      setState(() {
        timeLeft = "Time Left 0s";
      });
    } else {
      setState(() {
        timeLeft = "Time Left ${duration.inSeconds}s";
      });
    }
  }

  getProgress() {
    if (time == null || duration == null) {
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
      print('Current position: $p');
      time = await audioPlayer.getDuration();
      duration = p;
      if (duration == null) {
        timeLeft = "Time Left 0s/0s";
      } else {
        timeLeft = "Time Left ${duration.inSeconds}s/${time / 1000}s";
      }
      if (time == null || duration == null) {
        progress = 0.0;
      } else {
        progress = (duration.inMilliseconds) / time;
      }
      print(progress);
      setState(() {});
    });
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print("$state");
      if (state == AudioPlayerState.PLAYING) {
        setState(() {
          isPlaying = true;
        });
      } else {
        if (mounted) {
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
```

## AudioPlayer for Local Files

The major change from playing remote files and local files is only about how we start playing, at the time we call `play` we need to pass another paramer called `isLoacal` to play a local file

First thing we need to pick a file and send it to the AudioPlayer Page where it gets played

```dart
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
```

Playing an audio file

```dart
await audioPlayer.play(audioFile.path, isLocal: true);
```

final but important `dispose`

```dart
@override
void dispose() async {
    await audioPlayer.release();
    await audioPlayer.dispose();
    super.dispose();
}
```
I will provide github link at the bottom

## AudioPlayer for Assets

Playing an Audio File from assets is different from others mode

Intialize Audio Player 

```dart
static AudioPlayer audioPlayer = AudioPlayer();
  
AudioCache audioPlayerCache = AudioCache(
    fixedPlayer: audioPlayer
);
```

to start playing a remote file call 

```dart
await audioPlayerCache.play("audio.mp3");
```
Remaining all are same as the other modes

final but important `dispose`

```dart
@override
void dispose() async {
    await audioPlayer.release();
    await audioPlayer.dispose();
    super.dispose();
}
```

Here is the complete AudioPlayer Code - Playing from Assets

```dart
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioAssets extends StatefulWidget {
  @override
  _AudioAssetsState createState() => _AudioAssetsState();
}

class _AudioAssetsState extends State<AudioAssets> {
  static AudioPlayer audioPlayer = AudioPlayer();
  
  AudioCache audioPlayerCache = AudioCache(
    fixedPlayer: audioPlayer
  );

  bool isPlaying = false;
  bool isStarted = false;
  Duration duration;
  int time;

  String timeLeft = "";
  double progress = 0.0;

  startPlaying() async{
    if(!isStarted) {
      await audioPlayerCache.play(
        "audio.mp3");
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
      print('Current position: $p');
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
    print(progress);
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
```
