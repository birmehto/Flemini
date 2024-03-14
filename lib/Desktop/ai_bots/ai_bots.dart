import 'package:flemini/Desktop/ai_bots/chat_page.dart';
import 'package:flemini/Desktop/controller/bard_controller.dart';
import 'package:flemini/Desktop/wigeds/my_drawer.dart';
import 'package:flemini/consts/prompt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DAiBots extends StatelessWidget {
  const DAiBots({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DBardAIController(userId: ''));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 217, 250),
      body: Row(
        children: [
          const Expanded(flex: 2, child: DMyDrawer()),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          'AI Chat Bots',
                          style: GoogleFonts.adamina(
                              fontSize: 20,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(), // Spacer to push the IconButton to the right
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Choose an AI Bot',
                        style: GoogleFonts.adamina(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        BotCard(
                          botName: 'SEO Specialist',
                          botDescription: 'John Doe',
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: seo,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Business Coach',
                          botDescription: 'Victoria Royal',
                          onPressed: () {
                            // Send task to AI
                            Get.offAll(() => DChatPage(aiPrompt: business));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Motivational Coach',
                          botDescription: 'Anthony Renwick',
                          onPressed: () {
                            controller.clearChatHistory();
                            Get.offAll(() => DChatPage(
                                  aiPrompt: motivational,
                                ));
                          },
                        ),
                        BotCard(
                            image: Image.asset(
                              'assets/images/flemini.png',
                              fit: BoxFit.cover,
                            ),
                            botName: 'Relationship Coach',
                            botDescription: 'Elizabeth Claire',
                            onPressed: () {
                              Get.offAll(() => DChatPage(
                                    aiPrompt: relationship,
                                  ));
                            }),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Cyber Security Specialist',
                          botDescription: 'Charli Sandford',
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: cybersecurity,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Life Coach',
                          botDescription: 'Matthew Doe',
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: lifecoach,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Career Counselor',
                          botDescription: 'Max Keighley',
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: careerCounselor,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Doctor',
                          botDescription: 'Matilda Fong',
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: doctor,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Accountant',
                          botDescription: 'Kiara Sidney',
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: accountant,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Poet',
                          botDescription: 'Isabel Tindal',
                          onPressed: () {
                            Get.offAll(() => DChatPage(
                                  aiPrompt: poet,
                                ));
                          },
                        ),
                        BotCard(
                          image: Image.asset(
                            'assets/images/flemini.png',
                            fit: BoxFit.cover,
                          ),
                          botName: 'Travel Guide',
                          botDescription: 'Jade Tripp',
                          onPressed: () {
                            Get.offAll(
                              () => DChatPage(
                                aiPrompt: travelguide,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BotCard extends StatelessWidget {
  final String botName;
  final String botDescription;
  final Image image;
  final VoidCallback onPressed;

  const BotCard({
    super.key,
    required this.botName,
    required this.image,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CircleAvatar(child: image)),
                  const SizedBox(width: 12),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                botName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                botDescription,
                style: TextStyle(
                  fontSize: 11,
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
