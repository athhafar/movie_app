import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_iat/model/gallery_model.dart';
import 'package:movie_app_iat/services/api_endpoint.dart';
import 'package:movie_app_iat/services/api_services.dart';

import '../model/detail_movie_model.dart';

class DetailMovieController extends GetxController {
  var detailMovietModel = Rxn<DetailMovieModel>();
  var loadingMovie = false.obs;
  var selectedID = 0.obs;

  //gallery
  var galleryModel = <Backdrops>[].obs;

  @override
  void onInit() {
    selectedID.value = Get.arguments;
    getDetailMovie();
    super.onInit();
  }

  void getDetailMovie() async {
    loadingMovie.value = true;
    try {
      var data = await ApiServices.api(
          type: APIMethod.get,
          endpoint: APiEndpoint.detail,
          param: "/${selectedID.value.toString()}");
      detailMovietModel.value = DetailMovieModel.fromJson(data);
      print('tesdetail  ${detailMovietModel.value}');
      loadingMovie.value = false;

      if (galleryModel.isEmpty) {
        getImage();
      }
    } catch (e) {
      loadingMovie.value = false;
      debugPrint('EROR DETAIL MOVIE CONTROLLLEER : ${e.toString()}');
    }
  }

  void getImage() async {
    loadingMovie.value = true;
    try {
      var data = await ApiServices.api(
          type: APIMethod.get,
          endpoint: APiEndpoint.detail,
          param: "/${selectedID.value.toString()}/images");
      if (data['backdrops'] != null) {
        var dataList = data['backdrops'] as List;
        debugPrint('data List Gallery $dataList');
        List<Backdrops> list =
            dataList.map((e) => Backdrops.fromJson(e)).toList();
        galleryModel.value = list;
        loadingMovie.value = false;
      } else {
        loadingMovie.value = false;
      }
    } catch (err) {
      loadingMovie.value = false;
      print('EERROR GET IMAGE : ${err.toString()}');
    }
  }
}
