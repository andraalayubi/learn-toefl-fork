import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_toefl/ip.dart';

Future<List<QuestionGroup>> fetchPracticeAll() async {
  final url = Uri.parse('http://localhost:3000/practice/all');
  // final url = Uri.parse('$ip/practice/all');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((json) => QuestionGroup.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch practice data');
  }
}

Future<QuestionDetail> fetchPracticeDetail(int id) async {
  final url = Uri.parse('http://localhost:3000/practice/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return QuestionDetail.fromJson(data);
  } else {
    throw Exception('Failed to fetch practice detail');
  }
}

class QuestionGroup {
  final String questionCategory;
  final List<QuestionGroupData> data;

  QuestionGroup({
    required this.questionCategory,
    required this.data,
  });

  factory QuestionGroup.fromJson(Map<String, dynamic> json) {
    final questionCategory = json['question_category'];
    final data = (json['data'] as List)
        .map((e) => QuestionGroupData.fromJson(e))
        .toList();

    return QuestionGroup(
      questionCategory: questionCategory,
      data: data,
    );
  }
}

class QuestionGroupData {
  final int id;
  final String name;
  final String jumlahQuestion;
  final String? nilaiUser;

  QuestionGroupData({
    required this.id,
    required this.name,
    required this.jumlahQuestion,
    this.nilaiUser,
  });

  factory QuestionGroupData.fromJson(Map<String, dynamic> json) {
    return QuestionGroupData(
      id: json['id'],
      name: json['name'],
      jumlahQuestion: json['jumlah_question'],
      nilaiUser: json['nilai_user'] ?? null,
    );
  }
}

class QuestionDetail {
  final String name;
  final String readingText;
  final String questionCategory;
  final List<Question> questions;

  QuestionDetail({
    required this.name,
    required this.readingText,
    required this.questionCategory,
    required this.questions,
  });

  factory QuestionDetail.fromJson(Map<String, dynamic> json) {
    final questions = (json['questions'] as List)
        .map((e) => Question.fromJson(e))
        .toList();

    return QuestionDetail(
      name: json['name'],
      readingText: json['reading_text'] ?? '',
      questionCategory: json['question_category'],
      questions: questions,
    );
  }
}

class Question {
  final int id;
  final String questionText;
  final String correctAnswer;
  final List<String> answerOptions;
  int? userAnswer;

  Question({
    required this.id,
    required this.questionText,
    required this.correctAnswer,
    required this.answerOptions,
    this.userAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final answerOptions = (json['answer_options'] as List).cast<String>();

    return Question(
      id: json['id'],
      questionText: json['question_text'],
      correctAnswer: json['correct_answer'] ?? '',
      answerOptions: answerOptions,
    );
  }
}