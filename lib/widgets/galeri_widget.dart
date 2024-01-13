import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app_iat/controller/detail_movie_controller.dart';
import 'package:movie_app_iat/utilities/helpers.dart';
import 'package:movie_app_iat/widgets/photo_view_gallery_dialog.dart';

import '../model/gallery_model.dart';

class GaleriWidget extends StatelessWidget {
  GaleriWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailMovieController controller = Get.find();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: MasonryGridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: getTotalBackdropsCount(controller.galleryModel),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.dialog(
                      DetailGallery(
                        title: "POSTER",
                        currentIndex: index,
                        images: getBackdropsFilePaths(controller.galleryModel),
                      ),
                      useSafeArea: false,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: Get.width * 0.33 - 8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "$baseImage${controller.galleryModel[index].filePath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int getTotalBackdropsCount(List<Backdrops>? galleryModels) {
    return galleryModels?.length ?? 0;
  }

  List<String> getBackdropsFilePaths(List<Backdrops>? galleryModels) {
    return galleryModels
            ?.map<String>((backdrop) => "$baseImage${backdrop.filePath}")
            .toList() ??
        [];
  }
}
