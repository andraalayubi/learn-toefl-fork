import 'package:flutter/material.dart';
import 'package:learn_toefl/widget/question_widgets.dart';

class ExerciseQuestionAnswer extends StatefulWidget {
  const ExerciseQuestionAnswer({super.key});

  @override
  _ExerciseQuestionAnswerState createState() => _ExerciseQuestionAnswerState();
}

class _ExerciseQuestionAnswerState extends State<ExerciseQuestionAnswer> {
  int currentQuestion = 0;
  int totalQuestions = 10;
  String? selectedOption1;
  String? selectedOption2;
  String? selectedOption3;

  void updateProgress() {
    setState(() {
      if (currentQuestion < totalQuestions) {
        currentQuestion += 1;
      } // Menambah progres setiap kali pertanyaan dijawab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level 1',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '10 Questions',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF0D0443),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                Text(
                  '$currentQuestion/$totalQuestions', // Teks progress dengan format "1/10"
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: currentQuestion / totalQuestions, // Progress bar
                    backgroundColor:
                        Colors.grey[300], // Warna latar belakang progress bar
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF0D0443),), // Warna progress bar
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBox(
                    // Menggunakan CustomBox untuk bacaan
                    title: 'Example 1',
                    content:
                        'The railroad was not the first institution to impose regularity on society, or to draw attention to the importance of precise timekeeping. For as long as merchants have set out their wares at daybreak and communal festivities have been celebrated, people have been in rough agreement with their neighbors as to the time of day. \nThe value of this tradition is today more apparent than ever. Were it not for public acceptance of a single yardstick of time, social life would be unbearably chaotic: the massive daily transfers of goods, services, and information would proceed in fits and starts; the very fabric of modern society would begin to unravel.',
                  ),

                  const SizedBox(height: 16), // Spasi antara elemen

                  // Question 1
                  QuestionBox(
                    questionNumber: 1,
                    question: 'What is the main idea of the passage?',
                    options:  [
                      'In modern society we must make more time for our neighbors.',
                      'An accepted way of measuring time is essential for the smooth functioning of society.',
                      'Society judges people by the times at which they conduct certain activities.',
                      'The traditions of society are timeless.',
                    ],
                    selectedOption: selectedOption1,
                    onSelect: (option) {
                      if (selectedOption1 != option) {
                        // Memeriksa apakah opsi berbeda
                        setState(() {
                          selectedOption1 = option;
                          updateProgress(); // Update progress hanya jika pertanyaan baru dijawab
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 16), // Spasi lagi

                  // Question 2
                  QuestionBox(
                    questionNumber: 2,
                    question:
                        'According to the second paragraph, the phrase “this tradition” refers to',
                    options: [
                      'The practice of starting the business day at dawn',
                      'Friendly relations between neighbors',
                      'The railroad’s reliance on time schedules',
                      'People’s agreement on the measurement of time',
                    ],
                    selectedOption: selectedOption2,
                    onSelect: (option) {
                      if (selectedOption2 != option) {
                        // Memeriksa apakah opsi berbeda
                        setState(() {
                          selectedOption2 = option;
                          updateProgress(); // Hanya update progress jika opsi berbeda
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 16), // Spasi lagi

                  // Question 3
                  QuestionBox(
                    questionNumber: 3,
                    question: 'Question 3: Which of the following is correct?',
                    options: [
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4',
                    ],
                    selectedOption: selectedOption2,
                    onSelect: (option) {
                      if (selectedOption3 != option) {
                        // Memeriksa apakah opsi berbeda
                        setState(() {
                          selectedOption3 = option;
                          updateProgress(); // Hanya update progress jika opsi berbeda
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
