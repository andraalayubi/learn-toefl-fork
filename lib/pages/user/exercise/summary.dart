import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:learn_toefl/pages/user/exercise/exercise.dart';
import 'package:learn_toefl/services/input_nilai.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/widget/bottom_navigation.dart';
import 'package:learn_toefl/widget/question_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Summary extends StatefulWidget {
  final int questionId;
  final int score;
  final int? correct;
  final int? incorrect;
  final QuestionDetail? detail;
  final String? textTitle;
  final String? text;

  const Summary({
    required this.score,
    this.correct,
    this.incorrect,
    required this.questionId,
    this.detail,
    this.text,
    this.textTitle,
  });

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  bool isSpeaking = false;
  @override
  void initState() {
    super.initState();
    _insertToDb();
    print(widget);
    print(widget.correct);
  }

  void _insertToDb() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('id');

      insertNilai(widget.questionId, id!, widget.score);
      print(id);
    } catch (e) {
      print('Error while getting user info: $e');
    }
  }

  FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    if (!isSpeaking) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(text);
      await flutterTts.setPitch(1);
      await flutterTts.setVolume(0.5);
      await flutterTts.setSpeechRate(0.5);
      setState(() {
        isSpeaking = true;
      });
    } else {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan ikon back
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Summary',
          style: tFOnt(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D0443),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/sparkle.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        'Congratulations!\nYou have completed all questions.',
                        textAlign: TextAlign.center,
                        style: tFOnt(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Your score is:',
                        style: tFOnt(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              '${widget.score}',
                              style: tFOnt(
                                fontSize: 73,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          if (widget.correct != null)
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${widget.correct} Correct',
                                    style: tFOnt(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${widget.incorrect} Incorrect',
                                    style: tFOnt(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            if (widget.text != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomBox(
                  title: widget.textTitle!,
                  content: widget.text!,
                ),
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.detail?.questions.length ?? 0,
              itemBuilder: (context, index) {
                final question = widget.detail?.questions[index];
                if (question != null) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: QuestionBox(
                        questionNumber: index + 1,
                        question: question.questionText,
                        correctAnswer: question.correctAnswer,
                        options: question.answerOptions,
                        selectedOption: question.userAnswer,
                        onSelect: (option) {
                          // Tidak melakukan apa-apa karena ini adalah halaman ringkasan
                        },
                        isSummary: true,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              child: IconButton(
                onPressed: () => speak(widget.text!),
                icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: mColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()));
                },
                child: Text(
                  'Back to Home',
                  style: tFOnt(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
