import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/grammar.dart';
import 'package:learn_toefl/pages/lesson.dart';
import 'package:learn_toefl/pages/translate.dart';
import 'package:learn_toefl/utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'ToeTion',
                  style: tFOnt(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: mColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Card(
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
                                  'Welcome to ToeTion',
                                  style: tFOnt(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ignite Your TOEFL Journey with Passion and Purpose!',
                                  style: tFOnt(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/welcome.png', // Ganti dengan path gambar Anda
                          width: 150,
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    children: [
                      // TOEFL Prep Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOEFL Prep',
                            style: tFOnt(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LessonPage()));
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
                                      'assets/images/vocabolary.png', // Ganti dengan path gambar Anda
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
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GrammarPage(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 150,
                                margin: const EdgeInsets.only(right: 10),
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
                                      'assets/images/grammar.png', // Ganti dengan path gambar Anda
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
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TranslatePage(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 150,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Color.fromARGB(255, 230, 244, 255),
                                      Color.fromRGBO(156, 200, 235, 0.8)
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
                                      'assets/images/translation.png', // Ganti dengan path gambar Anda
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Translate',
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
                      const SizedBox(
                        height: 20,
                      ),

                      // HISTORY Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'History',
                            style: tFOnt(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(
                                  //   width: 1,
                                  //   color: Colors.black,
                                  // ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 197, 196, 196),
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: SizedBox(
                                  width: 159.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            'assets/images/video.png', // Ganti dengan path gambar Anda

                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 255, 174, 148),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    'Grammar',
                                                    style: tFOnt(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  'Listening 1  - 100 idiom ',
                                                  style: tFOnt(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // ARTICLE Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Article',
                            style: tFOnt(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(
                                  //   width: 1,
                                  //   color: Colors.black,
                                  // ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 197, 196, 196),
                                      offset: Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 159.2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            'assets/images/article.jpg', // Ganti dengan path gambar Anda
                                            // width: 159.2,
                                            height: 180,
                                            width: 159.2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  'Listening 1  - 100 idioms',
                                                  style: tFOnt(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text(
                                                  'detik.com',
                                                  style: tFOnt(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
