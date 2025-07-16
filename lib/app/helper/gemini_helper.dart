import 'package:http/http.dart' as http;

import 'all_imports.dart';

class GeminiHelper {
  static Future<Map<String, dynamic>> fetch(
      {required String systemPrompt,
      String? text,
      Map? data,
      int tries = 1}) async {
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
    // final dio = Dio(BaseOptions(connectTimeout: Duration.zero));
    // var request = await dio.post(
    //     'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=${apiKeys["gemini"]}',
    //     options: Options(
    //       headers: headers,
    //     ), data: bodyEncoded);
    var request = await http.post(
      Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${getApi("gemini")}'),
      headers: headers,
      body: bodyEncoded,
    );
    EasyLoading.dismiss();

    if (request.statusCode == 200) {
      String response = request.body;
      print(response);
      try {
        Map<String, dynamic> decoded = json.decode(json
            .decode(response)["candidates"][0]["content"]["parts"][0]["text"]
            .toString());
        return decoded;
      } catch (e) {
        if (tries <= 3) {
          tries++;

          return await fetch(
              systemPrompt: systemPrompt, text: text, data: data, tries: tries);
        } else {
          showSnackbar(message: "Error generating recipe");
          return {};
        }
      }
    } else {
      List errorCodes = [400, 403, 429];
      if (errorCodes.contains(request.statusCode)) {
        EasyLoading.show();
        await DatabaseHelper.updateApiIndex(apiName: "gemini");
        Map<String, dynamic> reData =
            await fetch(systemPrompt: systemPrompt, data: data, text: text);
        EasyLoading.dismiss();
        return reData;
      }
      // print(request.statusCode);
      return {};
    }
  }
}
