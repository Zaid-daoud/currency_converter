import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

class ApiHelper {
  static Future<Map<String, dynamic>> get({required String url, Map<String, String>? headers}) async {
    try {
      final uri = Uri.tryParse(url);
      if (uri != null) {
        log(url, name: "Url: ");
        var response = await http.get(uri, headers: headers);
        log(response.statusCode.toString(), name: 'Response status: ');
        log(response.body.toString(), name: 'Response body: ');
        if (response.statusCode == 200) {
          return jsonDecode(response.body) as Map<String, dynamic>;
        } else {
          throw ServerException(message: "Error with status code : ${response.statusCode}");
        }
      }
      throw ServerException(message: "Failed to parse $url");
    } on ServerException {
      rethrow;
    } catch (e) {
      return throw ServerException(message: "$url: $e");
    }
  }
}
