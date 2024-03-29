import 'package:firebase_auth/firebase_auth.dart';
import 'package:flemini/Desktop/screens/login.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const DHomePage();
          } else {
            return const DLoginPage();
          }
        },
      ),
    );
  }
}
