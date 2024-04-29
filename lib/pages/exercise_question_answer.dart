import 'package:flutter/material.dart';

void main() => runApp(ExerciseApp());

class ExerciseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExerciseQuestionAnswer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExerciseQuestionAnswer extends StatefulWidget {
  @override
  _ExerciseQuestionAnswerState createState() => _ExerciseQuestionAnswerState();
}

class _ExerciseQuestionAnswerState extends State<ExerciseQuestionAnswer> {
  final List<QuestionSet> questionSets = [
    QuestionSet(
      title: 'Listening',
      questions: [
        Question('This is a short passage about a topic.',
            'What is the main idea of the passage?'),
        Question('Another passage providing context.',
            'What does this passage focus on?'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '10 Questions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0D0443),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kotak pertama dengan bacaan soal
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '   The railroad was not the first institution to impose regularity on society, or to draw attention to the importance of precise timekeeping. For as long as merchants have set out their wares at daybreak and communal festivities have been celebrated, people have been in rough agreement with their neighbors as to the time of day.\n   The value of this tradition is today more apparent than ever. Were it not for public acceptance of a single yardstick of time, social life would be unbearably chaotic: the massive daily transfers of goods, services, and information would proceed in fits and starts; the very fabric of modern society would begin to unravel.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 16), // Spasi di antara elemen

            // Kotak kedua untuk soal kuis
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question 1: What is the main idea of the passage?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // Pilihan ganda
                  ...[
                    'A: The passage describes a main idea.',
                    'B: The passage discusses a specific topic.',
                    'C: The passage explores various themes.',
                    'D: The passage is focused on one central concept.',
                  ].map((option) {
                    return ListTile(
                      title: Text(option),
                      leading: Radio(
                        value: option,
                        groupValue:
                            'B: The passage discusses a specific topic.',
                        onChanged: (value) {
                          setState(() {
                            // Tangani perubahan
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionSet {
  final String title;
  final List<Question> questions;

  QuestionSet({required this.title, required this.questions});
}

class Question {
  final String text;
  final String answer;
  Question(this.text, this.answer);
}
