import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

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
              "./assets/images/welcome-ilustration.png",
              width: MediaQuery.of(context).size.width * 4.5 / 5,
            ),
            RichText(
              text: TextSpan(
                style: tFOnt(fontSize: 30, fontWeight: FontWeight.bold),
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
            const SizedBox(
              height: 20,
            ),
            Text(
              'Uncomplicate your TOEFL preparation\nwith ToeTion. Integrates lessons and\npractice tests seamlessly, empowering\nyou to excel without the hassle.',
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
