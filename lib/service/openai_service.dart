// lib/services/openai_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/constants.dart';

class OpenAIService {
  static final apiKey = dotenv.env['openAiApiKey'];

  static Future<String> getChatbotResponse(String userMessage) async {
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a kind and supportive mental health assistant. Help the user reflect and feel calm."
          },
          {
            "role": "user",
            "content": userMessage,
          }
        ],
      }),
    );

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  }
}
