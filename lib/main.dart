<<<<<<< HEAD
import 'package:flemini/ai_bot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flemini',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AiBot(),
    );
  }
}
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:flemini/cloud_sevices/firebase_options.dart';
import 'package:flemini/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: 'AIzaSyBtUZz3LmlB5Hy8f0T2e2NfQIUdR5jYNzo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flemini',
      home: ResponsiveSetting(),
    );
  }
}
>>>>>>> 8a78b94 (added)
