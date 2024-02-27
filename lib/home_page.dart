import 'package:flemini/bard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BardAIController controller = Get.put(BardAIController());
    TextEditingController textField = TextEditingController();

    //Image Picker function to get image from gallery

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 214, 255),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(
            "assets/bard_logo.svg",
            width: 10,
          ),
        ),
        title: const Text(
          "Flemini",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 165, 125, 233),
              fontSize: 17,
              fontFamily: 'Sixtyfour'),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                controller.clearChatHistory();
                // controller.sendPrompt("Hello what can you do for me ");
              },
              icon: const Icon(
                Icons.delete_sweep_outlined,
                size: 32,
                color: Colors.deepPurpleAccent,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 15),
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
                                  " How can i be a best software developer");
                            },
                            child: const Text(
                                "😍 How can i be a best software developer"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Obx(() => Column(
                          children: controller.historyList
                              .map(
                                (e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        child: Center(
                                          child: Text(
                                            e.system == "user" ? "🧑" : "🤖",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                          child: Text(
                                        e.message
                                            .toString()
                                            .replaceAll('**', ''),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 1.0,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ))
                  ],
                ),
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
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SvgPicture.asset(
                      "assets/bard_logo.svg",
                      width: 40,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textField,
                      decoration: const InputDecoration(
                          hintText: "Ask me anything ...",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? GestureDetector(
                            onTap: () {
                              controller.stopResponse();
                            },
                            child: const Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    backgroundColor:
                                        Color.fromARGB(255, 237, 186, 247),
                                  ),
                                  Icon(
                                    Icons.stop_rounded,
                                    size: 30,
                                    color: Color.fromARGB(255, 151, 93, 252),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              final text = textField.text;

                              if (text.isNotEmpty) {
                                controller.sendPrompt(text);
                                textField.clear();
                              }
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
                ]),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
