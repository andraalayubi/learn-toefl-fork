import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/pages/onboarding/screen1.dart';
import 'package:learn_toefl/pages/onboarding/screen2.dart';
import 'package:learn_toefl/pages/onboarding/screen3.dart';
import 'package:learn_toefl/pages/onboarding/screen4.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  String buttonText = "Skip";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            if (index == 3) {
              buttonText = "Get Started";
            } else {
              buttonText = "Skip";
            }
            setState(() {});
          },
          controller: pageController,
          children: const [Screen1(), Screen2(), Screen3(), Screen4()],
        ),
        Container(
          alignment: const Alignment(0, 0.8),
          child: SmoothPageIndicator(
            controller: pageController,
            count: 4,
            effect: ExpandingDotsEffect(activeDotColor: mColor),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  buttonText,
                  style: tFOnt(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
