import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flemini/Mobile/model/bard_model.dart';
import 'package:flemini/cloud_sevices/save_data.dart';
import 'package:flemini/consts/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIController extends GetxController {
  AIController({required this.userId});
  RxList<Bardmodel> historyList = RxList<Bardmodel>([]);
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  RxBool isLoading = false.obs;
  bool shouldProcessResponse = true;

  Future<void> sendPrompt({String? prompt, String? text}) async {
    debugPrint('Prompt:> $prompt');
    debugPrint('text:> $text');

    if ((text?.trim().isNotEmpty ?? false)) {
      isLoading.value = true;
      saveMessageToFirestore(userId!, text!, 'user');

      historyList.add(Bardmodel(system: "user", message: text));

      final body = {
        'contents': [
          {
            "role": "user",
            "parts": [
              {"text": prompt}
            ]
          },
          {
            "role": "model",
            "parts": [
              {
                "text":
                    "Hello there! Is there anything I can help you with today?"
              }
            ]
          },
          {
            'role': 'user',
            'parts': [
              {'text': text}
            ]
          }
        ],
        'generationConfig': {
          "temperature": 0.9,
          "topK": 1,
          "topP": 1,
          "maxOutputTokens": 2048,
          "stopSequences": []
        },
        'safetySettings': [
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_ONLY_HIGH"
          }
        ],
      };

      final response = await http.post(Uri.parse(baseUrl + apiKey2),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (!shouldProcessResponse) {
        isLoading.value = false;
        return;
      }

      final responseData = jsonDecode(response.body);
      final bardReply =
          responseData["candidates"][0]["content"]["parts"][0]["text"];

      // Save AI reply to Firestore
      saveMessageToFirestore(userId!, bardReply, 'model');

      historyList.add(Bardmodel(system: "model", message: bardReply));
      isLoading.value = false;
    }
  }

  void stopResponse() {
    shouldProcessResponse = false;
  }

  void clearChatHistory() {
    historyList.clear();
  }
}
