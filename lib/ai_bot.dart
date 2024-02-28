import 'package:flemini/bard_controller.dart';
import 'package:flemini/data.dart';
import 'package:flemini/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiBot extends StatefulWidget {
  const AiBot({super.key});

  @override
  State<AiBot> createState() => _AiBotState();
}

class _AiBotState extends State<AiBot> {
  BardAIController controller = Get.put(BardAIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  // controller.sendPrompt(prompt: "", text: seo);
                  Get.to(HomePage(type: seo));
                },
                child: const Text('seo ai')),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Get.to(const HomePage(
                    type: 'doctor',
                  ));
                },
                child: const Text('Doctor ai')),
          ),
        ],
      ),
    );
  }
}
