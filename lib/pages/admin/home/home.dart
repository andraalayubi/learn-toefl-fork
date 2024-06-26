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
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ToeTion',
                style: tFOnt(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration:
                    const BoxDecoration(color: mColor, shape: BoxShape.circle),
                child: IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () => _showLogoutConfirmationDialog(context)),
              ),
            ],
          ),
        ),
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
                          ColorFiltered(
                            colorFilter: const ColorFilter.matrix(<double>[
                              0.2126,
                              0.7152,
                              0.0722,
                              0,
                              0,
                              0.2126,
                              0.7152,
                              0.0722,
                              0,
                              0,
                              0.2126,
                              0.7152,
                              0.0722,
                              0,
                              0,
                              0,
                              0,
                              0,
                              1,
                              0,
                            ]),
                            child: Image.asset(
                              'assets/images/iconVideo_3.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
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
                            ColorFiltered(
                              colorFilter: const ColorFilter.matrix(<double>[
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0.2126,
                                0.7152,
                                0.0722,
                                0,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                              ]),
                              child: Image.asset(
                                'assets/images/iconVideo_2.png',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         'TOEFL Exercise',
            //         style: tFOnt(
            //           fontWeight: FontWeight.w700,
            //           fontSize: 18,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const ExercisePage()),
            //             );
            //           },
            //           child: Container(
            //             height: 250,
            //             decoration: BoxDecoration(
            //               gradient: const LinearGradient(
            //                 colors: [
            //                   Colors.white,
            //                   Color.fromARGB(255, 233, 244, 255),
            //                   Color.fromARGB(255, 148, 179, 255),
            //                 ],
            //                 stops: [0, 0.5, 1],
            //                 begin: Alignment.topLeft,
            //                 end: Alignment.bottomRight,
            //               ),
            //               borderRadius: BorderRadius.circular(10),
            //               border: Border.all(
            //                 width: 0.8,
            //                 color: Colors.black12,
            //               ),
            //               boxShadow: const [
            //                 BoxShadow(
            //                   color: Color.fromARGB(255, 197, 196, 196),
            //                   offset: Offset(2, 4),
            //                   blurRadius: 5,
            //                   spreadRadius: 0,
            //                 )
            //               ],
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Image.asset(
            //                   'assets/images/iconVideo_4.png',
            //                   width: 70,
            //                   height: 70,
            //                   fit: BoxFit.cover,
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(top: 10.0),
            //                   child: Text(
            //                     'Exercise',
            //                     style: tFOnt(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w700,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/window.png',
                width: 170,
                height: 170,
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure want to logout?',
                style: tFOnt(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: TextButton(
                child: Text(
                  'Cancel',
                  style: tFOnt(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 171, 52, 44),
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: TextButton(
                child: Text(
                  'Logout',
                  style: tFOnt(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _logout(context);
                  showCustomSnackbar(
                    context,
                    'Logout Successful',
                    Colors.green,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showCustomSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                style: tFOnt(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
