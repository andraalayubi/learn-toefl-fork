import 'package:flutter/material.dart';
import 'package:learn_toefl/pages/update_profile.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
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
              SizedBox(
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
              SizedBox(
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
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D0443),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
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
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFF0D0443),
                  ),
                ),
                title: Text('Favorite Lesson'),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[50],
                  ),
                  child: Icon(Icons.arrow_forward_ios_sharp),
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
                title: Text('History'),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[50],
                  ),
                  child: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
              SizedBox(
                height: 90,
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
