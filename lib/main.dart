import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:learn_toefl/screens/exercise.dart';
import 'package:learn_toefl/screens/homepage.dart';
import 'package:learn_toefl/screens/exercise.dart';
import 'package:learn_toefl/screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Container(color: Colors.white, child: Center(child: Text('Page 11'))),
    Container(color: Colors.white, child: Center(child: Text('Page 2'))),
    Container(color: Colors.white, child: Center(child: Text('Page 3'))),
  ];

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Curved Navigation Bar Example'),
  //     ),
  //     body: _pages[_currentIndex],
  //     bottomNavigationBar: CurvedNavigationBar(
  //       height: 75,
  //       color: Color(0xFF0D0443),
  //       backgroundColor: Color.fromARGB(255, 255, 255, 255),
  //       items: <Widget>[
  //         Icon(
  //           Icons.home,
  //           size: 40,
  //           color: Colors.white,
  //         ),
  //         Icon(
  //           Icons.task_alt_sharp,
  //           size: 40,
  //           color: Colors.white,
  //         ),
  //         Icon(
  //           Icons.person,
  //           size: 40,
  //           color: Colors.white,
  //         ),
  //       ],
  //       onTap: (index) {
  //         setState(() {
  //           _currentIndex = index;
  //         });
  //       },
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Curved Navigation Bar Example'),
      // ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          ExercisePage(),
          ProfilPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 75,
        color: Color(0xFF0D0443),
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 40,
            color: Colors.white,
          ),
          Icon(
            Icons.task_alt_sharp,
            size: 40,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 40,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
