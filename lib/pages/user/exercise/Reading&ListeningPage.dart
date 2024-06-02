import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:learn_toefl/pages/user/exercise/summary.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/widget/audio_widget.dart';
import 'package:learn_toefl/widget/question_widgets.dart';

class ReadingTest extends StatefulWidget {
  final int questionGroupId;

  const ReadingTest({Key? key, required this.questionGroupId})
      : super(key: key);

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
  List<bool?> questionAnswered = [];

  @override
  void initState() {
    super.initState();
    _questionGroupId = widget.questionGroupId;
    print(_questionGroupId);
    _futureQuestionDetail = fetchPracticeDetail(_questionGroupId);
  }

  void updateProgress() {
    setState(() {
      _currentQuestionIndex =
          questionAnswered.where((answered) => answered != null).length;
      print(questionAnswered);
      print(_currentQuestionIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: FutureBuilder<QuestionDetail>(
          future: _futureQuestionDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomAppBarWidget(questionCategory: '');
            } else if (snapshot.hasError) {
              return CustomAppBarWidget(questionCategory: 'Error');
            } else {
              final detail = snapshot.data!;
              final questionCategory = detail.questionCategory;
              return CustomAppBarWidget(questionCategory: questionCategory);
            }
          },
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
                    value: _totalQuestions == 0
                        ? 0
                        : _currentQuestionIndex / _totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFF0D0443)),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$_currentQuestionIndex/$_totalQuestions',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
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

                  if (questionAnswered.isEmpty) {
                    questionAnswered =
                        List<bool?>.filled(_totalQuestions, null);
                  }
                  
                  final correct = detail.questions
                      .where((question) =>
                          question.userAnswer != null &&
                          question.userAnswer! == question.correctAnswer)
                      .length;
                  final incorrect = detail.questions.length - correct;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (detail.readingText.isNotEmpty &&
                            detail.questionCategory != 'Listening')
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CustomBox(
                              title: 'Passage',
                              content: detail.readingText,
                            ),
                          ),
                        if (detail.questionCategory == 'Listening')
                          AudioWidget(
                              questionGroupId: _questionGroupId,
                              audioPlayer: audioPlayer,
                              text: detail.readingText),
                        ...detail.questions.asMap().entries.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: QuestionBox(
                                  questionNumber: entry.key + 1,
                                  question: entry.value.questionText,
                                  correctAnswer: entry.value.correctAnswer,
                                  options: entry.value.answerOptions,
                                  selectedOption: entry.value.userAnswer,
                                  onSelect: (option) {
                                    setState(() {
                                      entry.value.userAnswer = option;
                                      questionAnswered[entry.key] = true;
                                      updateProgress();
                                    });
                                  },
                                ),
                              ),
                            ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Summary(
                                        questionId: _questionGroupId,
                                        score: correct * 10,
                                        correct: correct,
                                        incorrect: incorrect,
                                        detail: detail,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D0443),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
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

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String questionCategory;

  CustomAppBarWidget({required this.questionCategory});

  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBar(),
      child: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionCategory + ' Test',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0D0443),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
