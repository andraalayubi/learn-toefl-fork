import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

class SpeakingTest extends StatefulWidget {
  const SpeakingTest({super.key});

  @override
  State<SpeakingTest> createState() => _SpeakingTestState();
}

class _SpeakingTestState extends State<SpeakingTest> {
  String providedText =
      'The flower petals are very large in size and release odors such as the smell of carrion Flower buds that have medicinal properties resulting in the passage of this flower are often looted This plant is native habitat on the island of Sumatra especially in Bengkulu Jambi and South Sumatra';
  var textSpeech = 'Click on Mic to Record';
  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  double accuracy = 0.0;

  void checkMic() async {
    bool micAvailable = await speechToText.initialize();

    if (micAvailable) {
      print('Mic Available');
    } else {
      print('User Denied to use speech micro');
    }
  }

  @override
  void initState() {
    super.initState();
    checkMic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: ClipPath(
          clipper: CustomAppBar(),
          child: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Speaking Test',
                  style: tFOnt(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF0D0443),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFC0D6E8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  providedText,
                  style: tFOnt(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
              height: 290,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textSpeech,
                  style: tFOnt(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Accuracy: ${accuracy.toStringAsFixed(2)}%',
                  style: tFOnt(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
                if (!isListening) {
                  bool micAvailable = await speechToText.initialize();
                  if (micAvailable) {
                    setState(() {
                      isListening = true;
                    });

                    speechToText.listen(
                        listenFor: const Duration(seconds: 120),
                        onResult: (result) {
                          setState(() {
                            textSpeech = result.recognizedWords;
                            accuracy =
                                calculateAccuracy(providedText, textSpeech);
                            print("Provided Text: $providedText");
                            print("Speech Text: $textSpeech");
                            print("Accuracy: ${accuracy.toStringAsFixed(2)}%");
                          });
                        });
                  }
                } else {
                  setState(() {
                    isListening = false;
                    speechToText.stop();
                  });
                }
              },
              child: CircleAvatar(
                backgroundColor: mColor,
                child: isListening
                    ? const Icon(
                        Icons.record_voice_over,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double calculateAccuracy(String providedText, String textSpeech) {
    String lowerProvidedText = providedText.toLowerCase();
    String lowerTextSpeech = textSpeech.toLowerCase();

    int matchingCharacters = 0;
    int totalCharacters = lowerProvidedText.length;

    int minCharacters = totalCharacters < lowerTextSpeech.length
        ? totalCharacters
        : lowerTextSpeech.length;

    for (int i = 0; i < minCharacters; i++) {
      if (lowerProvidedText[i] == lowerTextSpeech[i]) {
        matchingCharacters++;
      }
    }

    double accuracy = (matchingCharacters / totalCharacters) * 100;
    return accuracy;
  }
}

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
