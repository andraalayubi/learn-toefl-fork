import 'package:flutter/material.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:learn_toefl/services/input_nilai.dart';
import 'package:learn_toefl/widget/question_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Summary extends StatefulWidget {
  final int questionId;
  final int score;
  final int correct;
  final int incorrect;
  final QuestionDetail? detail; // tambahkan parameter ini

  Summary({
    required this.score,
    required this.correct,
    required this.incorrect,
    required this.questionId,
    this.detail, // dan ini
  });

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  void initState() {
    super.initState();
    _insertToDb();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Summary',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFF0D0443),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(children: [
              Container(
                color: Colors.white,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/sparkle.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            'Congratulations!\nYou have completed all questions.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Your score is:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${widget.score}',
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        '${widget.correct} Correct',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        '${widget.incorrect} Incorrect',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red[700],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ]),
                        ]),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: Image.asset(
                    //     "assets/images/writing.png",
                    //     width: 250,
                    //     height: 250,
                    //     alignment: Alignment.bottomRight,
                    //   ),
                    // ),
                  ))
            ]),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.detail?.questions.length ?? 0,
              itemBuilder: (context, index) {
                final question = widget.detail?.questions[index];
                if (question != null) {
                  return QuestionBox(
                    questionNumber: index + 1,
                    question: question.questionText,
                    correctAnswer: question.correctAnswer,
                    options: question.answerOptions,
                    selectedOption: question.userAnswer,
                    onSelect: (option) {
                      // Tidak melakukan apa-apa karena ini adalah halaman ringkasan
                    },
                    isSummary: true,
                  );
                } else {
                  return SizedBox
                      .shrink(); // Mengembalikan widget kosong jika question adalah null
                }
              },
            ),
          ],
        )));
  }
}
