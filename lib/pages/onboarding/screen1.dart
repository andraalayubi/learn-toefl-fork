import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

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
                  "./assets/images/welcome-ilustration.png",
                  width: isLandscape
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width * 0.9,
                ),
                SizedBox(height: isLandscape ? 10 : 20),
                RichText(
                  text: TextSpan(
                    style: tFOnt(
                        fontSize: isLandscape ? 24 : 30,
                        fontWeight: FontWeight.bold),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Welcome to Toe',
                          style: TextStyle(
                            color: mColor,
                          )),
                      TextSpan(
                        text: 'Tion',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 134, 95),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isLandscape ? 10 : 20),
                Text(
                  'Uncomplicate your TOEFL preparation\nwith ToeTion. Integrates lessons and\npractice tests seamlessly, empowering\nyou to excel without the hassle.',
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
