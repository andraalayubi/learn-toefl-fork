import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ListeningQuestionPage extends StatefulWidget {
  @override
  _ListeningQuestionPageState createState() => _ListeningQuestionPageState();
}

class _ListeningQuestionPageState extends State<ListeningQuestionPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    // Load audio file from assets or remote URL
    String audioUrl = 'https://webaudioapi.com/samples/audio-tag/chrono.mp3';
    await audioPlayer.setSourceUrl(audioUrl);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Question Page'),
      ),
      body: Column(
        children: [
          Slider(
            value: position.inSeconds.toDouble(),
            max: duration.inSeconds.toDouble(),
            onChanged: (value) {
              audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (isPlaying) {
                    audioPlayer.pause();
                  } else {
                    audioPlayer.resume();
                  }
                },
              ),
            ],
          ),
          // Tambahkan pertanyaan dan jawaban di sini
        ],
      ),
    );
  }
}