import 'package:flutter/material.dart';
import 'package:learn_toefl/models/question.dart';
import 'package:learn_toefl/pages/user/exercise/ReadingPage.dart';
import 'package:learn_toefl/utilities.dart';

class Exercise extends StatefulWidget {
  const Exercise({super.key});

  @override
  _Exercise createState() => _Exercise();
}

class _Exercise extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "EXERCISE",
            style: tFOnt(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF0D0443),
      ),
      backgroundColor: const Color(0xFF0D0443),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          // height: double.infinity,
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.9),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildHeader(containerWidth),
              const SizedBox(height: 30),
              _buildExerciseMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double containerWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D0443),
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.8),
          //     spreadRadius: 2,
          //     blurRadius: 10,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: tFOnt(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: "Vocabulary",
                      style: tFOnt(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          " is the cornerstone of communication, shaping our thoughts into articulate expressions.",
                      style: tFOnt(),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              'assets/images/writing.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseMenu() {
    return FutureBuilder<List<QuestionGroup>>(
      future: fetchPracticeAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final questionGroups = snapshot.data!;
          print(questionGroups);
          return Column(
            children: [
              _buildMenuItem(
                "Listening",
                'assets/images/iconVideo_1.png',
                questionGroups
                    .firstWhere(
                      (group) => group.questionCategory == 'Listening',
                      orElse: () => QuestionGroup(
                          questionCategory: 'Listening', data: []),
                    )
                    .data,
              ),
              // const SizedBox(height: 10),
              // _buildMenuItem(
              //   "Speaking",
              //   'assets/images/iconVideo_2.png',
              //   questionGroups
              //       .firstWhere((group) => group.questionCategory == 'Speaking')
              //       .data.map((item) => item.name)
              //       .toList(),
              // ),
              const SizedBox(height: 10),
              _buildMenuItem(
                "Reading",
                'assets/images/iconVideo_3.png',
                questionGroups
                    .firstWhere(
                      (group) => group.questionCategory == 'Reading',
                      orElse: () => QuestionGroup(
                          questionCategory: 'Reading', data: []),
                    )
                    .data,
              ),
              // const SizedBox(height: 10),
              // _buildMenuItem(
              //   "Writing",
              //   'assets/images/iconVideo_4.png',
              //   questionGroups
              //       .firstWhere((group) => group.questionCategory == 'Writing')
              //       .data.map((item) => item.name)
              //       .toList(),
              // ),
            ],
          );
        }
      },
    );
  }

  Widget _buildMenuItem(
    String title,
    String imagePath,
    List<QuestionGroupData> levels,
    // int levelDone,
    // int totalLevels,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.0, color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            shape: const Border(),
            title: Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: tFOnt(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      RichText(
                        text: TextSpan(
                          style: tFOnt(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          children: [
                            TextSpan(
                              text: '${levels.length} Levels',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            children: levels.map((level) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.name, // "Level 1"
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${level.jumlahQuestion} Questions', // "10 Questions"
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 58,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 11, 70),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${level.nilaiUser}', // Skor contoh
                    textAlign: TextAlign.center,
                    style: tFOnt(
                      fontSize: 9,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ReadingTest(questionGroupId: level.id),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
