import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_toefl/models/user.dart';
import 'package:learn_toefl/ip.dart';

class AuthService {
  Future<User?> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$ip/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$ip/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setBool('isAdmin', data['isAdmin']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isAdmin');
  }
}
