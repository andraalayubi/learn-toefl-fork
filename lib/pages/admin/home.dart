import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/services/auth_service.dart';

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
        title: Text('Admin Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(child: Text('Welcome Admin!')),
    );
  }
}
