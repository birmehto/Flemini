import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateText(String userInput) async {
  const apiKey =
      "AIzaSyBtUZz3LmlB5Hy8f0T2e2NfQIUdR5jYNzo"; // Replace with your actual API key
  const apiUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$apiKey";

  final requestBody = {
    "contents": [
      {
        "role": "user",
        "parts": [
          {"text": userInput}
        ]
      }
    ],
    "generationConfig": {
      "temperature": 0.9,
      "topK": 1,
      "topP": 1,
      "maxOutputTokens": 2048,
      "stopSequences": []
    },
    "safetySettings": [
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
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      }
    ]
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    final generatedText = responseData['contents'][0]['parts'][0]['text'];
    return generatedText;
  } else {
    throw Exception('Failed to generate text: ${response.statusCode}');
  }
}
