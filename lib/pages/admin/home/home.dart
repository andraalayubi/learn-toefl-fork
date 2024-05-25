import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/admin/exercise/exercise.dart';
import 'package:learn_toefl/pages/admin/exercise/subexercise_page.dart';
import 'package:learn_toefl/pages/admin/grammar/grammar_page.dart';
import 'package:learn_toefl/pages/admin/lesson/lesson_page.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/services/auth_service.dart';
import 'package:learn_toefl/utilities.dart';

class AdminHomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            'Toetion',
            style: tFOnt(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Container(
              decoration: BoxDecoration(color: mColor, shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () => _logout(context),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      mColor,
                      mColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.4, 1],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dashboard Admin',
                              style: tFOnt(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   'assets/images/welcome.png', // Ganti dengan path gambar Anda
                    //   width: 150,
                    //   height: 150,
                    //   fit: BoxFit.fitHeight,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'TOEFL Prep',
                    style: tFOnt(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LessonPage()));
                    },
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                            Color.fromARGB(255, 255, 241, 236),
                            Color.fromRGBO(255, 148, 113, 0.4)
                          ],
                          stops: [0, 0.14, 0.42, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 0.8,
                          color: Colors.black12,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 197, 196, 196),
                            offset: Offset(2, 4),
                            blurRadius: 5,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/vocabolary.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Lesson',
                              style: tFOnt(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GrammarPage()),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              Color.fromRGBO(255, 253, 240, 0.65),
                              Color.fromRGBO(255, 241, 114, 0.6)
                            ],
                            stops: [0, 0.5, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.8,
                            color: Colors.black12,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 197, 196, 196),
                              offset: Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/grammar.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Grammar',
                                style: tFOnt(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'TOEFL Exercise',
                    style: tFOnt(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExercisePage()),
                        );
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              Color.fromARGB(255, 233, 244, 255),
                              Color.fromARGB(255, 148, 179, 255),
                            ],
                            stops: [0, 0.5, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.8,
                            color: Colors.black12,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 197, 196, 196),
                              offset: Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/iconVideo_4.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Exercise',
                                style: tFOnt(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
