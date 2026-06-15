import 'package:app_berita_roni/config/api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/session.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String username = "";
  String full_name = "";
  String email = "";
  String gambar = "";

  void _loadSession() async {
    Map<String, dynamic> session = await SessionManager.getSession();
    setState(() {
      username = session['username'];
      full_name = session['full_name'];
      email = session['email'];
      gambar = session['gambar'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Color(0xFF220033)],
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "${ApiService.base_url}/$gambar",
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    full_name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(email, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              margin: const EdgeInsets.all(15),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Full Name"),
                subtitle: Text(full_name),
              ),
            ),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Email"),
                subtitle: Text(email),
              ),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: (){
                  context.go('/');
                },
                child:  Text("HOME PAGE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
