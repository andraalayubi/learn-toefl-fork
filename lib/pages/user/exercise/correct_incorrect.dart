import 'package:flutter/material.dart';
import 'package:learn_toefl/widget/question_widgets.dart'; // Widget kustom untuk soal
import 'package:learn_toefl/pages/user/exercise/summary.dart'; 

class CorrectIncorrect extends StatefulWidget {
  const CorrectIncorrect({Key? key}) : super(key: key);

  @override
  _CorrectIncorrectState createState() => _CorrectIncorrectState();
}

class _CorrectIncorrectState extends State<CorrectIncorrect> {
  int currentQuestion = 0;
  int totalQuestions = 10;
  String? selectedOption1;
  String? selectedOption2;
  String? selectedOption3;

  final Map<int, String> correctAnswers = {
    1: 'An accepted way of measuring time is essential for the smooth functioning of society.',
    2: 'People’s agreement on the measurement of time.',
    3: 'Option 1',
  };

void updateProgress() {
  setState(() {
    currentQuestion += 1;
    if (currentQuestion == totalQuestions) {
      // Misalnya, Anda menghitung skor dari jawaban yang benar
      int correct = 0;
      int incorrect = 0;

      if (isCorrect(1, selectedOption1)) correct++;
      else incorrect++;
      if (isCorrect(2, selectedOption2)) correct++;
      else incorrect++;
      if (isCorrect(3, selectedOption3)) correct++;
      else incorrect++;

      int score = ((correct / totalQuestions) * 100).toInt(); 


      // Sekarang, berikan argumen yang diperlukan saat navigasi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Summary(
            score: score.toInt(), // Pastikan parameter diisi
            correct: correct, // Parameter jumlah benar
            incorrect: incorrect, // Parameter jumlah salah
          ),
        ),
      );
    }
  });
}


  bool isCorrect(int questionNumber, String? selectedOption) {
    return correctAnswers[questionNumber] == selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Correct or Incorrect?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '$currentQuestion/$totalQuestions Questions',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0D0443),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  '$currentQuestion/$totalQuestions',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(50),

                    value: currentQuestion / totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF0D0443),),
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
                  QuestionBox(
                    questionNumber: 1,
                    question: 'What is the main idea of the passage?',
                    options: [
                      'In modern society we must make more time for our neighbors.',
                      'An accepted way of measuring time is essential for the smooth functioning of society.',
                      'Society judges people by the times at which they conduct certain activities.',
                      'The traditions of society are timeless.',
                    ],
                    selectedOption: selectedOption1,
                    onSelect: (option) {
                      setState(() {
                        selectedOption1 = option;
                        updateProgress();
                      });
                    },
                  ),
                  if (selectedOption1 != null) ...[
                    const SizedBox(height: 16),
                    _buildCorrectIncorrectBox(1, selectedOption1),
                  ],
                  const SizedBox(height: 16),
                  QuestionBox(
                    questionNumber: 2,
                    question: 'According to the second paragraph, the phrase “this tradition” refers to?',
                    options: [
                      'The practice of starting the business day at dawn',
                      'Friendly relations between neighbors',
                      'The railroad’s reliance on time schedules',
                      'People’s agreement on the measurement of time',
                    ],
                    selectedOption: selectedOption2,
                    onSelect: (option) {
                      setState(() {
                        selectedOption2 = option;
                        updateProgress();
                      });
                    },
                  ),
                  if (selectedOption2 != null) ...[
                    const SizedBox(height: 16),
                    _buildCorrectIncorrectBox(2, selectedOption2),
                  ],
                  const SizedBox(height: 16),
                  QuestionBox(
                    questionNumber: 3,
                    question: 'Which of the following is correct?',
                    options: [
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4',
                    ],
                    selectedOption: selectedOption3,
                    onSelect: (option) {
                      setState(() {
                        selectedOption3 = option;
                        updateProgress();
                      });
                    },
                  ),
                  if (selectedOption3 != null) ...[
                    const SizedBox(height: 16),
                    _buildCorrectIncorrectBox(3, selectedOption3),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildCorrectIncorrectBox(int questionNumber, String? selectedOption) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isCorrect(questionNumber, selectedOption) ? Colors.green : Colors.red,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(12.0),
//       child: Text(
//         isCorrect(questionNumber, selectedOption)
//             ? 'Correct!'
//             : 'Incorrect.\n The correct answer is: ${correctAnswers[questionNumber]}',
//         style: TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     );
//   }
// }
 Widget _buildCorrectIncorrectBox(int questionNumber, String? selectedOption) {
    bool correct = isCorrect(questionNumber, selectedOption);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 1), // Jarak tambahan sebelum kotak
        Container(
          decoration: BoxDecoration(
            color: correct ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: correct
                      ? 'Correct!'
                      : 'Incorrect.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (!correct)
                  TextSpan(
                    text: ' The correct answer is: ${correctAnswers[questionNumber]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}