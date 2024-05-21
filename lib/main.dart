import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/admin/home.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/pages/auth/register.dart';
import 'package:learn_toefl/widget/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
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
                    return snapshot.data! ? AdminHomeScreen() : BottomNavigation();
                  }
                },
              );
            } else {
              return LoginScreen();
            }
          }
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => BottomNavigation(),
        '/admin_home': (context) => AdminHomeScreen(),
      },
    );
  }
}
