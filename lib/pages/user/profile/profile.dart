import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/pages/user/exercise/SpeakingPage.dart';
import 'package:learn_toefl/pages/user/pages/history_video.dart';
import 'package:learn_toefl/pages/user/profile/update_profile.dart';
import 'package:learn_toefl/pages/user/pages/fav_video.dart';
import 'package:learn_toefl/services/auth_service.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final AuthService _authService = AuthService();
  late String _username = '';
  late String _email = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  // Fungsi untuk mendapatkan informasi pengguna yang sedang login
  void _getUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username');
      final email = prefs.getString('email');
      if (username != null && email != null) {
        setState(() {
          _username = username;
          _email = email;
        });
      } else {
        throw Exception('Username or email not found in SharedPreferences');
      }
    } catch (e) {
      print('Error while getting user info: $e');
    }
  }

  void _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _navigateToUpdateProfile() async {
    final updatedUserInfo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UpdateProfile()),
    );

    if (updatedUserInfo != null) {
      setState(() {
        _username = updatedUserInfo['username'];
        _email = updatedUserInfo['email'];
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _username);
      await prefs.setString('email', _email);
    }
  }

  void showCustomSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 10,
        left: 10,
        right: 10,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Text(
                message,
                style: tFOnt(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Profile',
            style: tFOnt(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black),
                      borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/proud.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ' $_username',
                style: tFOnt(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                ' $_email ',
                style: tFOnt(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 140,
                height: 50,
                child: ElevatedButton(
                  onPressed: _navigateToUpdateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D0443),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: tFOnt(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavVideo(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[100],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xFF0D0443),
                    ),
                  ),
                  title: Text(
                    'Favorite Video',
                    style: tFOnt(),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[50],
                    ),
                    child: const Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryVideo(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[100],
                    ),
                    child: const Icon(
                      Icons.history,
                      color: Color(0xFF0D0443),
                    ),
                  ),
                  title: Text(
                    'History',
                    style: tFOnt(),
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[50],
                    ),
                    child: const Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              ListTile(
                onTap: () => _showLogoutConfirmationDialog(context),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[100],
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Colors.red[900],
                  ),
                ),
                title: Text(
                  'Logout',
                  style: tFOnt(color: Colors.red[900]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/window.png',
                width: 170,
                height: 170,
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure want to logout?',
                style: tFOnt(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: TextButton(
                child: Text(
                  'Cancel',
                  style: tFOnt(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 171, 52, 44),
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: TextButton(
                child: Text(
                  'Logout',
                  style: tFOnt(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _logout(context);
                  showCustomSnackbar(
                    context,
                    'Logout Successful',
                    Colors.green,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
