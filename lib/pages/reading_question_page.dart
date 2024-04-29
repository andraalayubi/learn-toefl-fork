import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ReadingQuestionPage extends StatefulWidget {
  @override
  _ReadingQuestionPageState createState() => _ReadingQuestionPageState();
}

class _ReadingQuestionPageState extends State<ReadingQuestionPage> {
  late Database _database;
  late List<Map<String, dynamic>> _questions;
  late Map<String, dynamic> _passage;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase('toefl.db');
    await _loadPassage();
    await _loadQuestions();
  }

  Future<void> _loadPassage() async {
    List<Map<String, dynamic>> passages = await _database.rawQuery(
        'SELECT name, reading_text FROM Question_Category WHERE id = 1');
    print(passages);
    if (passages.isNotEmpty) {
      _passage = passages.first;
    } else {
      _passage = {'name': '', 'reading_text': ''};
    }
  }

  Future<void> _loadQuestions() async {
    List<Map<String, dynamic>> questions = await _database.rawQuery(
        'SELECT q.id, q.question_text, a.id as answer_id, a.answer_text '
        'FROM Question q '
        'JOIN Answer a ON q.id = a.question_id '
        'WHERE q.question_category_id = 1');
    print(questions);
    _questions = questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Question'),
      ),
      body: _passage == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _passage['name']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(_passage['reading_text']!),
                  ),
                  SizedBox(height: 16),
                  ..._questions.map((question) {
                    return QuestionTile(
                      id: question['id'],
                      questionText: question['question_text'],
                      answers: _questions
                          .where((answer) =>
                              answer['question_id'] == question['id'])
                          .map((answer) => answer['answer_text'] as String)
                          .toList(),
                      correctAnswerId: question['answer_id'],
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}

class QuestionTile extends StatefulWidget {
  final int id;
  final String questionText;
  final List<String> answers;
  final int correctAnswerId;

  QuestionTile({
    required this.id,
    required this.questionText,
    required this.answers,
    required this.correctAnswerId,
  });

  @override
  _QuestionTileState createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile> {
  int? _selectedAnswerId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${widget.id}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(widget.questionText),
              SizedBox(height: 16),
              ...widget.answers
                  .map(
                    (answer) => RadioListTile(
                      title: Text(answer),
                      value: widget.answers.indexOf(answer),
                      groupValue: _selectedAnswerId,
                      onChanged: (value) {
                        setState(() {
                          _selectedAnswerId = value;
                        });
                      },
                    ),
                  )
                  .toList(),
              if (_selectedAnswerId != null)
                Text(
                  _selectedAnswerId == widget.correctAnswerId - 1
                      ? 'Correct'
                      : 'Incorrect',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedAnswerId == widget.correctAnswerId - 1
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          )),
    );
  }
}

extension<T> on Iterable<T> {
  Iterable<T> mapIndexed(T Function(int index, T item) f) {
    var i = 0;
    return map((item) => f(i++, item));
  }
}
