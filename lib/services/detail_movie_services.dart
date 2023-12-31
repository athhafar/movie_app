import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailMovieServices {
  static Future getDetailMovie({var id}) async {
    var response = await http
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$id'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjE0ZWM2ZDg1Y2UxNmM0N2UzZDk3YzlhYTM2NGIyNiIsInN1YiI6IjY0ZmVhYzE0ZGI0ZWQ2MTAzNDNlZTYwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NieZ6VPjub04ZolHWtxGhUzPHpNFnKQBi1epPkC7nEQ'
    });
    debugPrint('tesid :$id');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint('EROR DETAIL MOVIE${json.decode(response.body)}');
      return json.decode(response.body);
    }
  }

  static Future getGallery({var id}) async {
    var response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$id/images'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjE0ZWM2ZDg1Y2UxNmM0N2UzZDk3YzlhYTM2NGIyNiIsInN1YiI6IjY0ZmVhYzE0ZGI0ZWQ2MTAzNDNlZTYwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NieZ6VPjub04ZolHWtxGhUzPHpNFnKQBi1epPkC7nEQ'
        });
    debugPrint('tes image id $id');
    debugPrint('API Response Images: ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint('ERROR DETAIL MOVIE: ${response.statusCode}');
      debugPrint('EROR DETAIL MOVIE${json.decode(response.body)}');
      return json.decode(response.body);
    }
  }
}
