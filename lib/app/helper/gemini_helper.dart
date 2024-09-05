import 'all_imports.dart';
import 'package:http/http.dart' as http;

class GeminiHelper {
  static Future<Map<String, dynamic>> fetch(
      {required String systemPrompt, String? text, Map? data}) async {
    EasyLoading.show();
    String bodyEncoded = json.encode({
      "system_instruction": {
        "parts": [
          {
            "text": systemPrompt,
          }
        ]
      },
      "contents": [
        {
          "parts": [
            {
              "text": jsonEncode({
                "text": text ?? "",
                "data": data,
              }),
            }
          ]
        }
      ],
      "generationConfig": {"response_mime_type": "application/json"}
    });
    // print(bodyEncoded);
    var headers = {'Content-Type': 'application/json'};
    var request = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=${apiKeys["gemini"]}'),
      headers: headers,
      body: bodyEncoded,
    );
    EasyLoading.dismiss();

    if (request.statusCode == 200) {
      String response = request.body;
      print(response);
      if (request.body.isNotEmpty) {
        Map<String, dynamic> decoded = json.decode(json
            .decode(response)["candidates"][0]["content"]["parts"][0]["text"]);

        return decoded;
      }
      return {};
    } else {
      // print(request.statusCode);
      return {};
    }
  }
}
