import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  static Future getListMovie({var page}) async {
    var response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/now_playing?page=$page'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjE0ZWM2ZDg1Y2UxNmM0N2UzZDk3YzlhYTM2NGIyNiIsInN1YiI6IjY0ZmVhYzE0ZGI0ZWQ2MTAzNDNlZTYwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NieZ6VPjub04ZolHWtxGhUzPHpNFnKQBi1epPkC7nEQ'
        });

    debugPrint("response.body");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint('EROR MOVIE LIST ${json.decode(response.body)}');
      return json.decode(response.body);
    }
  }

  static Future getSearch(var query) async {
    var response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/search/movie?query=$query'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjE0ZWM2ZDg1Y2UxNmM0N2UzZDk3YzlhYTM2NGIyNiIsInN1YiI6IjY0ZmVhYzE0ZGI0ZWQ2MTAzNDNlZTYwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NieZ6VPjub04ZolHWtxGhUzPHpNFnKQBi1epPkC7nEQ'
        });
    debugPrint('tesquerysearch : $query');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint('ERROR GETSEARCH ${json.decode(response.body)}');
      return json.decode(response.body);
    }
  }
}
