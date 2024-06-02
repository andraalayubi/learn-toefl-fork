import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/pages/onboarding/onboarding.dart';
import 'package:learn_toefl/pages/admin/home/home.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/widget/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin') ?? false;
  }

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FutureBuilder<bool>(
            future: isLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data == true) {
                  return FutureBuilder<bool>(
                    future: isAdmin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return snapshot.data!
                            ? AdminHomeScreen()
                            : BottomNavigation();
                      }
                    },
                  );
                } else {
                  return LoginScreen();
                }
              }
            },
          ),
        ), // Replace with your actual home page
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnBoarding()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Image.asset("./assets/images/splashscreen.png"),
        ),
      ),
    );
  }
}
