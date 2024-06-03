import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

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
                  "./assets/images/lesson-ilustration.png",
                  width: isLandscape
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width * 0.9,
                ),
                SizedBox(height: isLandscape ? 10 : 20),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.brown.shade300, Colors.brown.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    'Lesson',
                    style: tFOnt(
                      fontSize: isLandscape ? 24 : 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: isLandscape ? 5 : 10),
                Text(
                  'Empower Your Learning',
                  style: tFOnt(
                    fontSize: isLandscape ? 18 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: isLandscape ? 10 : 20),
                Text(
                  'Spend less time worrying about your\nstudy plan and more time mastering\nyour skills for success.',
                  style: tFOnt(
                    fontSize: isLandscape ? 16 : 18,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isLandscape ? 20 : 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
