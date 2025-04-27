import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatService {
  static final apiKey = dotenv.env['openAiApiKey']; // Use dotenv/env file later
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String> sendMessage(String userMessage) async {
    final response = await http.post(
      Uri.parse(endpoint),
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
                "You are a friendly and supportive mental health assistant."
          },
          {"role": "user", "content": userMessage}
        ],
        "max_tokens": 150,
        "temperature": 0.7
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }
}
