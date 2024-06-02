import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

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
              "./assets/images/lesson-ilustration.png",
              width: MediaQuery.of(context).size.width * 4.5 / 5,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.brown.shade300, Colors.brown.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                'Lesson',
                style: tFOnt(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Text(
              'Empower Your Learning',
              style: tFOnt(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Spend less time worrying about your\nstudy plan and more time mastering\nyour skills for success.',
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
