import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/admin/home.dart';
import 'package:learn_toefl/pages/auth/register.dart';
import 'package:learn_toefl/services/auth_service.dart';
import 'package:learn_toefl/widget/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  void _login() async {
    try {
      await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      final prefs = await SharedPreferences.getInstance();
      final isAdmin = prefs.getBool('isAdmin') ?? false;

      if (isAdmin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello!\nWelcome Back',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15), backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
