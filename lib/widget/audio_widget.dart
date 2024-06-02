import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learn_toefl/widget/question_widgets.dart';

class AudioWidget extends StatefulWidget {
  final int questionGroupId;
  final String text;
  final AudioPlayer audioPlayer;

  AudioWidget({required this.questionGroupId, required this.audioPlayer, required this.text});

  @override
  _AudioWidgetState createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  bool isPlaying = false;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();
    setAudio();

    widget.audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    widget.audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    widget.audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    String audioUrl = 'audio/Level ${widget.questionGroupId}.mp3';
    await widget.audioPlayer.setSourceAsset(audioUrl);
  }

  @override
  void dispose() {
    widget.audioPlayer.resume();
    widget.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomBox(
            title: 'Instruction',
            content: widget.text,
          ),
        ),
        Slider(
          value: position.inSeconds.toDouble(),
          max: duration.inSeconds.toDouble(),
          onChanged: (value) {
            widget.audioPlayer.seek(Duration(seconds: value.toInt()));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (isPlaying) {
                    widget.audioPlayer.pause();
                  } else {
                    widget.audioPlayer.resume();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
