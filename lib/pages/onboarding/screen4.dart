import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "./assets/images/exercise-ilustration.png",
              width: MediaQuery.of(context).size.width * 4.5 / 5,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color.fromARGB(175, 76, 157, 224), Colors.brown.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                'Exercise',
                style: tFOnt(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Text(
              'Sharpen Your Skills',
              style: tFOnt(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Practice tests a breeze, so you can\nfocus on improving your skills and\ntracking your progress.',
              style: tFOnt(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
