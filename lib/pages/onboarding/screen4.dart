import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [mColor, Colors.transparent, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isLandscape ? 16.0 : 40.0,
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  "./assets/images/exercise-ilustration.png",
                  width: isLandscape
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width * 0.9,
                ),
                SizedBox(height: isLandscape ? 10 : 20),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Color.fromARGB(175, 76, 157, 224),
                      Colors.brown.shade900
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    'Exercise',
                    style: tFOnt(
                      fontSize: isLandscape ? 24 : 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: isLandscape ? 5 : 10),
                Text(
                  'Sharpen Your Skills',
                  style: tFOnt(
                    fontSize: isLandscape ? 18 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: isLandscape ? 10 : 20),
                Text(
                  'Practice tests a breeze, so you can\nfocus on improving your skills and\ntracking your progress.',
                  style: tFOnt(
                    fontSize: isLandscape ? 16 : 18,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isLandscape ? 20 : 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
