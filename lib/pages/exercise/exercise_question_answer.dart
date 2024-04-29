import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/exercise/exercise.dart';

class ExerciseQuestionAnswer extends StatefulWidget {
  const ExerciseQuestionAnswer({Key? key}) : super(key: key);

  @override
  _ExerciseQuestionAnswerState createState() => _ExerciseQuestionAnswerState();
}

class _ExerciseQuestionAnswerState extends State<ExerciseQuestionAnswer> {
  String? selectedOption; // Menyimpan pilihan jawaban yang dipilih

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kotak pertama dengan bacaan
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFFC0D6E8),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Example 1',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'The railroad was not the first institution to impose regularity on society, or to draw attention to the importance of precise timekeeping. For as long as merchants have set out their wares at daybreak and communal festivities have been celebrated, people have been in rough agreement with their neighbors as to the time of day. The value of this tradition is today more apparent than ever. Were it not for public acceptance of a single yardstick of time, social life would be unbearably chaotic: the massive daily transfers of goods, services, and information would proceed in fits and starts; the very fabric of modern society would begin to unravel.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16), // Spasi antara elemen

            // Kotak untuk pertanyaan
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(
                    0xFFFFFFFF), // Warna dan dekorasi sama seperti kotak pertama
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question 1:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'What is the main idea of the passage?', // Teks pertanyaan
                    style: TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 4),

                  // Pilihan ganda untuk pertanyaan
                  ...[
                    'In modern society, we must make more time for our neighbors.',
                    'An accepted way of measuring time is essential for the smooth functioning of society.',
                    'Society judges people by the times at which they conduct certain activities.',
                    'The traditions of society are timeless.',
                  ].map((option) {
                    final isSelected =
                        selectedOption == option; // Status pilihan
                    return GestureDetector(
                      // Untuk menangani klik pada kotak
                      onTap: () {
                        setState(() {
                          selectedOption =
                              isSelected ? null : option; // Toggle pilihan
                        });
                      },
                      child: Container(
                        child: Row(
                          // Gunakan Row untuk menampilkan kotak dan teks
                          children: [
                            Container(
                              width: 20, // Lebar kotak
                              height: 20, // Tinggi kotak
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.green
                                    : Colors
                                        .grey, // Hijau saat dipilih, abu-abu saat tidak
                                borderRadius:
                                    BorderRadius.circular(4), // Radius kotak
                              ),
                            ),
                            const SizedBox(
                                width: 8), // Spasi antara kotak dan teks
                            Text(
                              option, // Teks pilihan
                              style: TextStyle(fontSize: 14),
                              maxLines: 2,
                            ),
                          ],
                        ),
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
