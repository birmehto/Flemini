import 'package:firebase_auth/firebase_auth.dart';
import 'package:flemini/Desktop/wigeds/my_drawer.dart';
import 'package:flutter/material.dart';

class DProfilePage extends StatefulWidget {
  const DProfilePage({super.key});

  @override
  State<DProfilePage> createState() => _DProfilePageState();
}

class _DProfilePageState extends State<DProfilePage> {
  late String userName;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.email!.split('@')[0]; // Extract username
        userEmail = user.email!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 214, 255),
      drawer: const DMyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.deepPurpleAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 5),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/profile.png'), // Placeholder image
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  userEmail,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
