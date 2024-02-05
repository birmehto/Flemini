import 'dart:convert';

import 'package:flemini/bard_model.dart';
import 'package:flemini/data.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BardAIController extends GetxController {
  RxList historyList = RxList<Bardmodel>([
    // Bardmodel(system: "user", message: "Hi !"),
    // Bardmodel(system: "bard", message: "Hello! How can I assist you today?"),
  ]);

  RxBool isLoading = false.obs;
  void sendPrompt(String prompt) async {
    isLoading.value = true;
    var newHistory = Bardmodel(system: "user", message: prompt);
    historyList.add(newHistory);
    final body = {
      'prompt': {
        'text': prompt,
      },
    };

    final request = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    final response = jsonDecode(request.body);
    final bardReplay = response["candidates"][0]["output"];
    var newHistory2 = Bardmodel(system: "bard", message: bardReplay);
    historyList.add(newHistory2);

    isLoading.value = false;
  }

  void clearChatHistory() {
    historyList.clear();
  }
}
