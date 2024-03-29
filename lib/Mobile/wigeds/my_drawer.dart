import 'package:firebase_auth/firebase_auth.dart';
import 'package:flemini/Mobile/ai_bots/ai_bots.dart';
import 'package:flemini/Mobile/controller/bard_controller.dart';
import 'package:flemini/Mobile/screens/history.dart';
import 'package:flemini/Mobile/screens/home_page.dart';
import 'package:flemini/Mobile/screens/image_responce.dart';
import 'package:flemini/Mobile/screens/login.dart';
import 'package:flemini/Mobile/screens/profile.dart';
import 'package:flemini/cloud_sevices/authantication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  final BardAIController controller =
      Get.put(BardAIController(userId: 'userId'));
  String? userName;

  @override
  void initState() {
    super.initState();
    // Call a function to get user details when the widget initializes
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    // Get the current user from FirebaseAuth

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If the user is signed in, retrieve the user's name
      setState(() {
        userName =
            'Hello, ${user.email.toString().replaceAll('@gmail.com', '')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SafeArea(
            child: DrawerHeader(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 220, 214, 255)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProfilePage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 4,
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 35,
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/profile.png')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Text(
                    userName != null ? ' $userName' : 'Hello',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.clearChatHistory();
              Get.offAll(() => const HomePage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 220, 214, 255)),
                child: const ListTile(
                  enabled: true,
                  title: Text(
                    'Ai Chat',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.add),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(() => const ImageAi());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 220, 214, 255)),
                child: const ListTile(
                  enabled: true,

                  leading: Icon(Icons.image_rounded),
                  title: Text(
                    'Ai Image',
                    style: TextStyle(fontSize: 15),
                  ),
                  // trailing: Icon(Icons.person_4),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(() => const AiBots());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 220, 214, 255)),
                child: const ListTile(
                  enabled: true,

                  leading: Icon(Icons.chat_rounded),
                  title: Text(
                    'Ai Chat',
                    style: TextStyle(fontSize: 15),
                  ),
                  // trailing: Icon(Icons.person_4),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const History());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 220, 214, 255)),
                child: const ListTile(
                  enabled: true,
                  title: Text(
                    'History',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.history_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              signOut();
              Get.offAll(() => const LoginPage());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 220, 214, 255)),
                child: const ListTile(
                  enabled: true,
                  title: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 15),
                  ),
                  leading: Icon(Icons.login_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
