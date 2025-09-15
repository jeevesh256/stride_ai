import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String _apiKey = 'AIzaSyD7x2iHKovPb_SHcI6i5kHVs6uLvRl-Bsk';
  static const String _apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': [{'text': message}]}],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get response');
      }

      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] ?? 
             "Sorry, I couldn't process that.";
    } catch (e) {
      return "Sorry, there was an error processing your request.";
    }
  }
}
