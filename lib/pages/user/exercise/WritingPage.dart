//UNCOMMENT tapi gurung kesambung soko exercise

import 'package:flutter/material.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:learn_toefl/pages/user/exercise/summary.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:learn_toefl/widget/question_widgets.dart';

class WritingTest extends StatefulWidget {
  final int questionGroupId;
  const WritingTest({Key? key, required this.questionGroupId})
      : super(key: key);

  @override
  _WritingTestState createState() => _WritingTestState();
}

class _WritingTestState extends State<WritingTest> {
  late Future<QuestionDetail> _futureQuestionDetail;
  String? userResponse;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _futureQuestionDetail = fetchPracticeDetail(widget.questionGroupId);
  }

  void _calculateWordCount(String response) {
    // Split response into words
    List<String> words = response.split(' ');
    // Count words
    int wordCount = words.length;
    // Divide word count by 3
    setState(() {
      score = (wordCount / 3).floor(); // Using floor to get an integer result
    });
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
                  'Writing Test',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (detail.readingText.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: double.infinity,
                              child: CustomBox(
                                title: 'Instruction',
                                content: detail.readingText,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            child: ResponseBox(
                              onSelect: (response) {
                                setState(() {
                                  userResponse = response;
                                  _calculateWordCount(response);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Summary(
                                      questionId: widget.questionGroupId,
                                      score: score,
                                      textTitle: 'Sample Answer',
                                      text: detail.sampleAnswer,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D0443),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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

class ResponseBox extends StatefulWidget {
  final ValueChanged<String> onSelect;

  const ResponseBox({
    super.key,
    required this.onSelect,
  });

  @override
  State<ResponseBox> createState() => _ResponseBoxState();
}

class _ResponseBoxState extends State<ResponseBox> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Response:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type Your Answer',
              ),
              onChanged: (value) {
                print(value);
                widget.onSelect(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
