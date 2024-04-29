import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/grammar_video.dart';

class GrammarPage extends StatefulWidget {
  const GrammarPage({super.key});

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GRAMMAR',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0D0443),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Transform.translate(
                offset: Offset(0, -90),
                child: Container(
                  height: 235,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF0D0443),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search here",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 12, bottom: 12),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 252, 232, 177),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -110),
              child: Container(
                width: 360,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF0D0443),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Grammar serves as the backbone of language, ensuring clarity and precision in communication',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Image.asset(
                        'assets/images/reading-book.png',
                        width: 85,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -80),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Image.asset('assets/images/music.png',
                              width: 30, height: 30),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nouns",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "3 Material",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GrammarVideoPage()));
                          },
                          child: ListTile(
                            title: Text(
                              'Type and Basic Function',
                              style: TextStyle(fontSize: 9),
                            ),
                            trailing: Container(
                              width: 58,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 24, 11, 70),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                'Done',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Subjects, Objects, and Complements',
                            style: TextStyle(fontSize: 9),
                          ),
                          trailing: Container(
                            width: 58,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 24, 11, 70),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              '90%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Formation and Usage',
                            style: TextStyle(fontSize: 9),
                          ),
                          trailing: Container(
                            width: 58,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 24, 11, 70),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              '30%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Proper Nouns, Collective Nouns, and Abstract Nouns',
                            style: TextStyle(fontSize: 9),
                          ),
                          trailing: Container(
                            width: 58,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 24, 11, 70),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              '0%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Image.asset('assets/images/open-book.png',
                              width: 30, height: 30),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Adjectives",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "3 Material",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Image.asset('assets/images/open-book.png',
                              width: 30, height: 30),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Adverbs",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "3 Material",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 180);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height - 180);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
