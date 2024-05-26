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

  Future<bool?> login(String email, String password) async {
    print('login berjalan');
    try {
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

      if (response.statusCode == 308) {
        print('Redirect detected with status code 308');
        final redirectLocation = response.headers['location'];

        // Check if the redirect location is relative
        final redirectUri = Uri.parse(redirectLocation!);
        Uri newUri;

        if (redirectUri.hasScheme) {
          // Absolute URI
          newUri = redirectUri;
        } else {
          // Relative URI, construct the absolute URI
          final originalUri = Uri.parse('$ip/api/auth/login');
          newUri = originalUri.resolveUri(redirectUri);
        }

        print('Redirect location: $newUri');

        final redirectedResponse = await http.post(
          newUri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          }),
        );

        if (redirectedResponse.statusCode == 200) {
          final data = jsonDecode(redirectedResponse.body);
          print('Response Data: $data');

          if (data.containsKey('token') && data.containsKey('isAdmin')) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', data['token']);
            await prefs.setBool('isAdmin', data['isAdmin']);
            await prefs.setInt('id', data['user']['id']);
            await prefs.setString('username', data['user']['username']);
            await prefs.setString('email', data['user']['email']);
            return data['isAdmin'];
          } else {
            throw Exception('Invalid response structure');
          }
        } else {
          throw Exception('Failed to login after redirect');
        }
      } else if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response Data: $data');

        if (data.containsKey('token') && data.containsKey('isAdmin')) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', data['token']);
          await prefs.setBool('isAdmin', data['isAdmin']);
          await prefs.setInt('id', data['user']['id']);
          await prefs.setString('username', data['user']['username']);
          await prefs.setString('email', data['user']['email']);
          return data['isAdmin'];
        } else {
          throw Exception('Invalid response structure');
        }
      } else {
        print('Failed to login with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error during login: $e');
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('isAdmin');
    await prefs.remove('id');
    await prefs.remove('username');
    await prefs.remove('email');
  }
}
