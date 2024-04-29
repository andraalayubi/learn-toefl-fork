import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EXERCISE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D0443),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF0D0443),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: screenHeight, // Menutupi seluruh tinggi layar
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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0443),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: "Vocabulary",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        " is the cornerstone of communication, shaping our thoughts into articulate expressions.",
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
    );
  }

  Widget _buildExerciseMenu() {
    return Column(
      children: [
        _buildMenuItem(
          "Listening",
          'assets/images/music.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          5,
          10,
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          "Speaking",
          'assets/images/speaking.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          3,
          10,
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          "Reading",
          'assets/images/open-book.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          8,
          10,
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          "Writing",
          'assets/images/copy-writing.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          4,
          10,
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    String title,
    String imagePath,
    List<String> levels,
    int levelDone,
    int totalLevels,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      elevation: 5,
      color: Colors.white,
      child: ExpansionTile(
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(text: '$levelDone Level $totalLevels Done'),
                        TextSpan(
                          style: const TextStyle(
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
          final parts = level.split('\n');
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parts[0], // "Level 1"
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  parts[1], // "10 Questions"
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 58,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 24, 11, 70),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '0%', // Contoh nilai skor
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                      ExerciseQuestionAnswer(), // Navigasi ke ExerciseQuestionAnswer
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  ExerciseQuestionAnswer() {}
}
