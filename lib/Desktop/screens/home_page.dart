import 'package:firebase_auth/firebase_auth.dart';
import 'package:flemini/Desktop/controller/bard_controller.dart';
import 'package:flemini/Desktop/wigeds/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DHomePage extends StatefulWidget {
  const DHomePage({super.key});

  @override
  State<DHomePage> createState() => _DHomePageState();
}

class _DHomePageState extends State<DHomePage> {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    DBardAIController controller = Get.put(DBardAIController(userId: userId));
    TextEditingController textField = TextEditingController();
    ScrollController scrollController = ScrollController();

    scrollToBottom() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 217, 250),
      // appBar: AppBar(
      //   foregroundColor: Colors.deepPurple,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(20),
      //     ),
      //   ),
      //   title: const Center(
      //     child: Text(
      //       "Ai",
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         color: Color.fromARGB(255, 165, 125, 233),
      //         fontSize: 17,
      //         fontFamily: 'Sixtyfour',
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         controller.clearChatHistory();
      //       },
      //       icon: const Icon(
      //         Icons.delete_sweep_outlined,
      //         size: 32,
      //         color: Colors.deepPurpleAccent,
      //       ),
      //     ),
      //   ],
      // ),
      body: Row(
        children: [
          // Sidebar
          const Expanded(flex: 2, child: DMyDrawer()),
          // Main Content
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: scrollController,
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
                                'HomePage',
                                style: GoogleFonts.adamina(
                                    fontSize: 20,
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(), // Spacer to push the IconButton to the right
                              IconButton(
                                onPressed: () {
                                  controller.clearChatHistory();
                                },
                                icon: const Icon(Icons.delete_sweep_rounded,
                                    size: 25, color: Colors.deepPurpleAccent),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  controller.sendPrompt(
                                      prompt: 'hi',
                                      text:
                                          'How can I be the best software developer');
                                },
                                child: const Text(
                                    "😍 How can I be the best software developer"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Obx(
                          () => Column(
                            children: controller.historyList
                                .map(
                                  (e) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: e.system == "user"
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 182, 163, 236),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        e.system == "user"
                                            ? CircleAvatar(
                                                child: Image.asset(
                                                    'assets/images/profile.png'),
                                              )
                                            : CircleAvatar(
                                                child: Image.asset(
                                                    'assets/images/robo.png'),
                                              ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: SelectableText(
                                            e.message
                                                .toString()
                                                .replaceAll('**', ''),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SvgPicture.asset(
                              "assets/bard_logo.svg",
                              width: 40,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                controller.sendPrompt(
                                    prompt: 'hi', text: textField.text);
                              },
                              controller: textField,
                              decoration: const InputDecoration(
                                hintText: "Ask me anything ...",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => controller.isLoading.value
                                ? GestureDetector(
                                    onTap: () {
                                      Get.find<DBardAIController>()
                                          .stopResponse();
                                    },
                                    child: const Center(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            backgroundColor: Color.fromARGB(
                                                255, 237, 186, 247),
                                          ),
                                          Icon(
                                            Icons.stop_rounded,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 151, 93, 252),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () async {
                                      final text = textField.text;
                                      if (text.isNotEmpty) {
                                        controller.sendPrompt(
                                            text: text, prompt: 'hi');
                                        textField.clear();
                                      }
                                      scrollToBottom();
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor:
                                          Colors.blueAccent.withOpacity(0.7),
                                      child: const Center(
                                        child: Icon(
                                          Icons.send_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 5)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
