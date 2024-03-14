import 'package:flemini/Mobile/ai_bots/chat_page.dart';
import 'package:flemini/Mobile/controller/bard_controller.dart';
import 'package:flemini/Mobile/wigeds/my_drawer.dart';
import 'package:flemini/consts/prompt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiBots extends StatelessWidget {
  const AiBots({super.key});

  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController(userId: ''));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 214, 255),
      drawer: const MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Ai Bots',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Choose an AI Bot',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  BotCard(
                    botName: 'SEO Specialist',
                    botDescription: 'John Doe',
                    icon: '🤖',
                    onPressed: () {
                      controller.clearChatHistory();
                      Get.offAll(() => ChatPage(
                            aiPrompt: seo,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Business Coach',
                    botDescription: 'Victoria Royal',
                    onPressed: () {
                      // Send task to AI

                      Get.offAll(() => ChatPage(aiPrompt: business));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Motivational Coach',
                    botDescription: 'Anthony Renwick',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: motivational,
                          ));
                    },
                  ),
                  BotCard(
                      icon: '🤖',
                      botName: 'Relationship Coach',
                      botDescription: 'Elizabeth Claire',
                      onPressed: () {
                        Get.offAll(() => ChatPage(
                              aiPrompt: relationship,
                            ));
                      }),
                  BotCard(
                    icon: '🤖',
                    botName: 'Cyber Security Specialist',
                    botDescription: 'Charli Sandford',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: cybersecurity,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Life Coach',
                    botDescription: 'Matthew Doe',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: lifecoach,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Career Counselor',
                    botDescription: 'Max Keighley',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: careerCounselor,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Doctor',
                    botDescription: 'Matilda Fong',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: doctor,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Accountant',
                    botDescription: 'Kiara Sidney',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: accountant,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Poet',
                    botDescription: 'Isabel Tindal',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: poet,
                          ));
                    },
                  ),
                  BotCard(
                    icon: '🤖',
                    botName: 'Travel Guide',
                    botDescription: 'Jade Tripp',
                    onPressed: () {
                      Get.offAll(() => ChatPage(
                            aiPrompt: travelguide,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BotCard extends StatelessWidget {
  final String botName;
  final String botDescription;
  final String icon;
  final VoidCallback onPressed;

  const BotCard({
    super.key,
    required this.botName,
    required this.icon,
    required this.botDescription,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Center(
                  child: Text(
                    icon,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Text(
                botName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                botDescription,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
