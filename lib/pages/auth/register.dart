import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/services/auth_service.dart';
import 'package:learn_toefl/widget/bottom_navigation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  void _register() async {
    try {
      await _authService.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration successful')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration failed')));
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
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
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
              onPressed: _register,
              child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white),),
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
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
