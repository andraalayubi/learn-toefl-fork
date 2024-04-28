import 'package:flutter/material.dart';
import 'package:learn_toefl/database/practice.dart';

class ReadingQuestionPage extends StatefulWidget {
  @override
  _ReadingQuestionPageState createState() => _ReadingQuestionPageState();
}

class _ReadingQuestionPageState extends State<ReadingQuestionPage> {
  Future<List<Practice>>? futureReading;
  List<int>? selectedAnswers; // Track selected answers

  @override
  void initState() {
    super.initState();
    futureReading = fetchReading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Question Page'),
      ),
      body: FutureBuilder<List<Practice>>(
        future: futureReading,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var practices = snapshot.data;
            return ListView.builder(
              itemCount: practices!.length,
              itemBuilder: (context, practiceIndex) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(practices[practiceIndex].readingText),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(left: 16),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: practices[practiceIndex].questions.length,
                      itemBuilder: (context, questionIndex) {
                        if (selectedAnswers == null) {
                          selectedAnswers = List.filled(
                              practices[practiceIndex].questions.length, -1);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              practices[practiceIndex]
                                  .questions[questionIndex]
                                  .question,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...practices[practiceIndex]
                                .questions[questionIndex].answers.map(
                              (answer) {
                                int answerIndex = practices[practiceIndex]
                                    .questions[questionIndex]
                                    .answers
                                    .indexOf(answer);
                                return RadioListTile(
                                  title: Text(answer.answerText),
                                  value: answerIndex,
                                  groupValue: selectedAnswers![questionIndex],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAnswers![questionIndex] = value!;
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}