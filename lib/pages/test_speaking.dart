import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

class SpeakingTest extends StatefulWidget {
  const SpeakingTest({super.key});

  @override
  State<SpeakingTest> createState() => _SpeakingTestState();
}

class _SpeakingTestState extends State<SpeakingTest> {
  String providedText =
      'in todays interconnected world the significance of multiculturalism cannot be overstated as societies become increasingly diverse understanding and embracing cultural differences have become essential components of social cohesion and progress';
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
      appBar: AppBar(
        title: const Text('Speaking Test'),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
              height: 290,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(providedText),
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
                child: Text(textSpeech),
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
                  style: const TextStyle(
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
                            print("Akurasi: ${accuracy.toStringAsFixed(2)}%");
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
                child: isListening
                    ? const Icon(Icons.record_voice_over)
                    : const Icon(Icons.mic),
              ),
            )
          ],
        ),
      ),
    );
  }
  //logika menghitung akurasi

  double calculateAccuracy(String providedText, String textSpeech) {
    int matchingCharacters = 0;
    int totalCharacters = providedText.length;

    int minCharacters = totalCharacters < textSpeech.length
        ? totalCharacters
        : textSpeech.length;

    for (int i = 0; i < minCharacters; i++) {
      if (providedText[i] == textSpeech[i]) {
        matchingCharacters++;
      }
    }

    double accuracy = (matchingCharacters / totalCharacters) * 100;
    return accuracy;
  }
}
