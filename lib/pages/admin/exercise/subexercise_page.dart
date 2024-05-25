import 'package:flutter/material.dart';

class SubExercisePage extends StatefulWidget {
  const SubExercisePage({Key? key}) : super(key: key);

  @override
  State<SubExercisePage> createState() => _SubExercisePageState();
}

class _SubExercisePageState extends State<SubExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0), // Set the height of the AppBar
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/appbar-exercise.png'), // Path gambar yang diperbaiki
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(blurRadius: 50.0),
            ],
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                MediaQuery.of(context).size.width,
                100.0,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'WRITING',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
      body: _buildExerciseMenu(context),
    );
  }

  Widget _buildExerciseMenu(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          "Listening",
          'assets/images/iconVideo_1.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          5,
          10,
          context,
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          "Speaking",
          'assets/images/iconVideo_2.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          3,
          10,
          context,
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          "Reading",
          'assets/images/iconVideo_3.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          8,
          10,
          context,
        ),
        const SizedBox(height: 10),
        _buildMenuItem(
          "Writing",
          'assets/images/iconVideo_4.png',
          [
            "Level 1\n10 Questions",
            "Level 2\n10 Questions",
            "Level 3\n10 Questions",
            "Level 4\n10 Questions",
            "Level 5\n10 Questions",
          ],
          4,
          10,
          context,
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
    BuildContext context,
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
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          children: [
                            TextSpan(
                                text: '$levelDone Level $totalLevels Done'),
                            const TextSpan(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 11, 70),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    '0%', // Skor contoh
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                    ),
                  ),
                ),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const ExerciseQuestionAnswer(),
                //     ),
                //   );
                // },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
