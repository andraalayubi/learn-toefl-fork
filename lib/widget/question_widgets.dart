import 'package:flutter/material.dart';

// Widget Custom untuk Kotak
class CustomBox extends StatelessWidget {
  final String title;
  final String content;

  const CustomBox({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

// Widget Custom untuk Pertanyaan
class QuestionBox extends StatelessWidget {
  final int questionNumber;
  final String question;
  final String correctAnswer;
  final List<String> options;
  final String? selectedOption;
  final Function(String) onSelect;

  const QuestionBox({
    required this.questionNumber,
    required this.question,
    required this.correctAnswer,
    required this.options,
    this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
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
            'Question $questionNumber', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            question,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Column(
            children: options.map((option) {
              final isSelected = selectedOption == option;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8), // Jarak antar opsi
                child: GestureDetector(
                  onTap: () => onSelect(option),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8), // Jarak antara kotak dan teks
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedOption != null) ...[
          const SizedBox(height: 16),
          _buildCorrectIncorrectBox(
              questionNumber, selectedOption!, correctAnswer),
        ],
        const SizedBox(height: 16),
        ],
      ),
    );
  }

Widget _buildCorrectIncorrectBox(
      int questionNumber, String selectedOption, String correctAnswer) {
    final isCorrect = selectedOption == correctAnswer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 1),
        Container(
          decoration: BoxDecoration(
            color: isCorrect ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: isCorrect ? 'Correct!' : 'Incorrect.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (!isCorrect)
                  TextSpan(
                    text:
                        ' The correct answer is: $correctAnswer',
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