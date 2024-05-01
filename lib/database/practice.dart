import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_toefl/database/ip.dart';

Future<List<Practice>> fetchReading() async {
  final response =
      await http.get(Uri.parse('$ip/practice'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => Practice.fromJson(item)).toList();
  } else {
    // Jika respons tidak OK, lempar exception.
    throw Exception('Failed to load reading');
  }
}

class Practice {
  final String name;
  final String readingText;
  final List<Question> questions;

  Practice(
      {required this.name, required this.readingText, required this.questions});

  factory Practice.fromJson(Map<String, dynamic> json) {
    var questionJson = json['questions'] as List;
    List<Question> questionList =
        questionJson.map((i) => Question.fromJson(i)).toList();

    return Practice(
      name: json['name'],
      readingText: json['reading_text'],
      questions: questionList,
    );
  }
}

class Question {
  final String question;
  final List<Answer> answers;

  Question({required this.question, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    var answerJson = json['answers'] as List;
    List<Answer> answerList =
        answerJson.map((i) => Answer.fromJson(i)).toList();

    return Question(
      question: json['question'],
      answers: answerList,
    );
  }
}

class Answer {
  final String answerText;
  final bool correct;

  Answer({required this.answerText, required this.correct});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerText: json['answer_text'],
      correct: json['correct'],
    );
  }
}
