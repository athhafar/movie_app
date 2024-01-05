import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_iat/controller/movie_controller.dart';
import 'package:movie_app_iat/movie/detail_movie_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key});

  final TextEditingController textFieldController = TextEditingController();
  final MovieController controller = Get.put(MovieController());
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MOVIE APP",
          style: GoogleFonts.montserrat(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: textFieldController,
            onChanged: (value) {
              print("Kata yang dimasukkan: $value");
              if (_timer?.isActive ?? false) _timer?.cancel();
              _timer = Timer(const Duration(milliseconds: 200), () {
                controller.isSearch.value = value.isNotEmpty;
                controller.valueSearch.value = value;

                controller.searchValue();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.isSearch.value = false;
                  // controller.getListMovie();
                  controller.searchMovieModel.clear();
                  textFieldController.clear();
                  controller.valueSearch.value = "";

                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                icon: const Icon(
                  Icons.close,
                  size: 32,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Obx(
            () => controller.isSearch.value == false
                ? Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: controller.enablePullUp.value,
                      controller: refreshController,
                      onRefresh: () async {
                        controller.currentPage.value = 1;
                        controller.listMovie.clear();
                        controller.getListMovie();
                        await Future.delayed(const Duration(seconds: 1));
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        controller.currentPage.value++;
                        controller.getListMovie();
                        await Future.delayed(const Duration(seconds: 1));
                        refreshController.loadComplete();
                      },
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: Get.width / Get.height,
                        ),
                        itemCount: controller.listMovie.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 24,
                                  offset: Offset(0, 11),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () {
                                  Get.to(
                                    () => DetailMoviePage(),
                                    arguments: controller.listMovie[index].id,
                                  );
                                },
                                child: Container(
                                  // margin: const EdgeInsets.all(4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          controller.baseImage +
                                              controller
                                                  .listMovie[index].posterPath,
                                          height: 195,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '${controller.listMovie[index].title}\n',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          controller
                                              .listMovie[index].releaseDate,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: Get.width / Get.height,
                      ),
                      itemCount: controller.searchMovieModel.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 24,
                                offset: Offset(0, 11),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () {
                                Get.to(
                                  () => DetailMoviePage(),
                                  arguments:
                                      controller.searchMovieModel[index].id,
                                );
                              },
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        controller.baseImage +
                                                controller
                                                    .searchMovieModel[index]
                                                    .posterPath ??
                                            "https://i.ibb.co/S32HNjD/no-image.jpg",
                                        height: 195,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        '${controller.searchMovieModel[index].title}\n',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        controller.searchMovieModel[index]
                                            .releaseDate,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
