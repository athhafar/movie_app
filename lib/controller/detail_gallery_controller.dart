import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailGalleryController extends GetxController {
  var pageController = PageController();
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
