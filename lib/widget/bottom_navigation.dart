import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/user/exercise/exercise.dart';
import 'package:learn_toefl/pages/user/home/home_page.dart';
import 'package:learn_toefl/pages/user/profile/profile.dart';
import 'package:learn_toefl/utilities.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    Exercise(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: mColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Tooltip(
            message: 'Homepage',
            textStyle: tFOnt(color: Colors.white),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
          ),
          Tooltip(
            message: 'Exercise Page',
            textStyle: tFOnt(color: Colors.white),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.task_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          Tooltip(
            message: 'Profile Page',
            textStyle: tFOnt(color: Colors.white),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(38, 38, 66, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
