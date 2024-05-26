import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:learn_toefl/pages/user/exercise/summary.dart';
import 'package:learn_toefl/widget/question_widgets.dart';

class ReadingTest extends StatefulWidget { 
  final int questionGroupId;

  ReadingTest({Key? key, required this.questionGroupId}) : super(key: key);

  @override
  _ReadingTestState createState() => _ReadingTestState();
}

class _ReadingTestState extends State<ReadingTest> {
  late int _questionGroupId;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  late Future<QuestionDetail> _futureQuestionDetail;
  int _currentQuestionIndex = 0;
  int _totalQuestions = 0;
  String? selectedOption1;
  String? selectedOption2;
  String? selectedOption3;
  String? selectedOption4;
  String? selectedOption5;
  String? selectedOption6;
  String? selectedOption7;
  String? selectedOption8;
  String? selectedOption9;
  String? selectedOption10;

  @override
  void initState() {
    super.initState();
    _questionGroupId = widget.questionGroupId;
    print(_questionGroupId);
    _futureQuestionDetail = fetchPracticeDetail(_questionGroupId);

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

  void updateProgress() {
    setState(() {
      _currentQuestionIndex++;
    });
  }

  Future setAudio() async {
    // Load audio file from assets or remote URL
    String audioUrl = 'audio/Level ${widget.questionGroupId}.mp3';
    await audioPlayer.setSourceAsset(audioUrl);
  }

  @override
  void dispose() {
    audioPlayer.resume();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: ClipPath(
          clipper: CustomAppBar(),
          child: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                // Text(
                //   '$currentQuestion/$totalQuestions Questions',
                //   style: TextStyle(color: Colors.white, fontSize: 14),
                // ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(50),
                    value: _totalQuestions == 0 ? 0 : _currentQuestionIndex / _totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF0D0443)),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '$_currentQuestionIndex/$_totalQuestions',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<QuestionDetail>(
                  future: _futureQuestionDetail,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final detail = snapshot.data!;
                      _totalQuestions = detail.questions.length;
                      final allQuestionsAnswered =
                          _currentQuestionIndex == _totalQuestions;

                      if (allQuestionsAnswered) {
                        final correct = detail.questions
                            .where((question) =>
                                question.userAnswer != null &&
                                question.userAnswer! == question.correctAnswer)
                            .length;
                        final incorrect = detail.questions.length - correct;

                        // Navigasi ke halaman hasil
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Summary(
                                questionId: _questionGroupId,
                                score: correct * 10,
                                correct: correct,
                                incorrect: incorrect,
                              ),
                            ),
                          );
                        });
                      }
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (detail.readingText.isNotEmpty &&
                                detail.questionCategory != 'Listening')
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CustomBox(
                                  // Menggunakan CustomBox untuk bacaan
                                  title: 'Passage',
                                  content: detail.readingText,
                                ),
                              ),
                            if (detail.questionCategory == 'Listening')
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CustomBox(
                                      // Menggunakan CustomBox untuk bacaan
                                      title: 'Instruction',
                                      content: detail.readingText,
                                    ),
                                  ),
                                  Slider(
                                    value: position.inSeconds.toDouble(),
                                    max: duration.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      audioPlayer.seek(
                                          Duration(seconds: value.toInt()));
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow),
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
                                  ),
                                ],
                              ),
                            ...detail.questions.asMap().entries.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            16.0), // Menambahkan jarak antar QuestionBox
                                    child: QuestionBox(
                                      questionNumber: entry.key + 1,
                                      question: entry.value.questionText,
                                      correctAnswer: entry.value.correctAnswer,
                                      options: entry.value.answerOptions,
                                      selectedOption: entry.value.userAnswer,
                                      onSelect: (option) {
                                        if (entry.value.userAnswer == null) {
                                          entry.value.userAnswer = option;
                                          setState(() {
                                            switch (entry.key) {
                                              case 0:
                                                selectedOption1 = option;
                                                break;
                                              case 1:
                                                selectedOption2 = option;
                                                break;
                                              case 2:
                                                selectedOption3 = option;
                                                break;
                                              case 3:
                                                selectedOption4 = option;
                                                break;
                                            }
                                          });
                                          updateProgress();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      );
                    }
                  })),
        ],
      ),
    );
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