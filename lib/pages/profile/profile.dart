import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/auth/login.dart';
import 'package:learn_toefl/pages/profile/update_profile.dart';
import 'package:learn_toefl/pages/test_speaking.dart';
import 'package:learn_toefl/services/auth_service.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
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
                'Jia JNE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'jiaracing@gmail.com',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 140,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfile()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D0443),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
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
                title: const Text('Favorite Lesson'),
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
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[100],
                  ),
                  child: Icon(
                    Icons.history,
                    color: Color(0xFF0D0443),
                  ),
                ),
                title: const Text('History'),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpeakingTest()));
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
                      Icons.mic,
                      color: Color(0xFF0D0443),
                    ),
                  ),
                  title: const Text('Speaking'),
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
                onTap: () => _logout(context),
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
                  style: TextStyle(color: Colors.red[900]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
