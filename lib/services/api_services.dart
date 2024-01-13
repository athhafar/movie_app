import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_iat/utilities/helpers.dart';

enum APIMethod {
  post,
  get,
}

class ApiServices {
  static Future api({
    required var type,
    String endpoint = "",
    String param = "",
  }) async {
    var response;

    if (type == APIMethod.get) {
      response = await http.get(
        Uri.parse("$baseUrl$endpoint$param"),
        headers: {
          'Authorization': bearerToken,
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response("Time Out", 404);
        },
      );
    }

    debugPrint("response.body");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint('EROR SERVICES ${json.decode(response.body)}');
      return json.decode(response.body);
    }
  }
}
