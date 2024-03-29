import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_app_iat/model/movie_model.dart';
import 'package:movie_app_iat/services/api_endpoint.dart';
import 'package:movie_app_iat/services/api_services.dart';

import '../model/search_model.dart';

class MovieController extends GetxController {
  var listMovie = <MovieList>[].obs;
  var loadingMovie = false.obs;

  //search
  var searchMovieModel = <SearchModel>[].obs;
  var valueSearch = ''.obs;
  var isSearch = false.obs;

  //loadmore
  var currentPage = 1.obs;
  var enablePullUp = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListMovie();
    searchValue();
  }

  void getListMovie() async {
    loadingMovie.value = true;
    try {
      var data = await ApiServices.api(
        endpoint: APiEndpoint.movie,
        param: "?page=${currentPage.value.toString()}",
        type: APIMethod.get,
      );

      print('page  $currentPage');
      if (data['results'] != null) {
        var dataList = data['results'] as List;
        debugPrint("tes $dataList");
        List<MovieList> list =
            dataList.map((e) => MovieList.fromJson(e)).toList();
        if (list.isEmpty) {
          enablePullUp.value = false;
        }
        if (currentPage.value > data['page']) {
          currentPage.value = data['page'];
        } else {
          print('tes pagination');
          listMovie.addAll(list);
        }
      } else {
        loadingMovie.value = false;
      }
    } catch (e) {
      loadingMovie.value = false;
      debugPrint('EROR MOVIE CONTROLLLEER : ${e.toString()}');
    }
  }

  void searchValue() async {
    loadingMovie.value = true;

    try {
      var data = await ApiServices.api(
          type: APIMethod.get,
          endpoint: APiEndpoint.search,
          param: "?query=${valueSearch.value.toString()}");
      if (data['results'] != null) {
        var dataSearch = data['results'] as List;
        debugPrint('tessearch $dataSearch');
        List<SearchModel> list =
            dataSearch.map((e) => SearchModel.fromJson(e)).toList();
        searchMovieModel.value = list;
        loadingMovie.value = false;
      } else {
        loadingMovie.value = false;
      }
    } catch (e) {
      loadingMovie.value = false;
      debugPrint('EROR SEEARCH MOVIE : ${e.toString()}');
    }
  }
}
