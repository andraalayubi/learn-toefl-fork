import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakingTest extends StatefulWidget {
  final int questionGroupId;
  const SpeakingTest({Key? key, required this.questionGroupId}) : super(key: key);

  @override
  State<SpeakingTest> createState() => _SpeakingTestState();
}

class _SpeakingTestState extends State<SpeakingTest> {
  late Future<QuestionDetail> futureQuestionDetail;
  String instruction = '';
  String providedText = '';
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
    futureQuestionDetail = fetchPracticeDetail(widget.questionGroupId);
    futureQuestionDetail.then((questionDetail) {
      setState(() {
        instruction = questionDetail.readingText;
        providedText = questionDetail.sampleAnswer;
      });
    }).catchError((error) {
      print('Failed to fetch practice detail: $error');
    });
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
      body: FutureBuilder<QuestionDetail>(
        future: futureQuestionDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load data'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
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
                      child: Text(instruction),
                    ),
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
                                  accuracy = calculateAccuracy(
                                      providedText, textSpeech);
                                  print("Provided Text: $providedText");
                                  print("Speech Text: $textSpeech");
                                  print(
                                      "Accuracy: ${accuracy.toStringAsFixed(2)}%");
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
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
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
