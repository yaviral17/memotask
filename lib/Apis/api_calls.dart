import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:memotask/Apis/routes.dart';

class APICalls {
  static Future<Map<String, dynamic>> getRandomMCQs() async {
    var request = http.Request('GET', Uri.parse(APIRoutes.randomQuestionsUrl));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List data = jsonDecode(await response.stream.bytesToString());

      return {
        'isSuccess': true,
        'questions': data,
      };
    } else {
      return {
        'isSuccess': false,
        'message': 'Failed to fetch data',
        'code': response.statusCode
      };
    }
  }

  static Future<Map<String, dynamic>> getQuestionById(String questionId) async {
    var request =
        http.Request('GET', Uri.parse('${APIRoutes.questionById}/$questionId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      data['isSuccess'] = true;

      return data;
    } else {
      return {
        'isSuccess': false,
        'message': 'Failed to fetch data',
        'code': response.statusCode
      };
    }
  }
}
