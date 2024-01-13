import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_iat/controller/detail_movie_controller.dart';
import 'package:movie_app_iat/utilities/helpers.dart';
import 'package:movie_app_iat/widgets/galeri_widget.dart';

class DetailMoviePage extends StatelessWidget {
  DetailMoviePage({super.key});

  final DetailMovieController controller = Get.put(DetailMovieController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => controller.loadingMovie.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          '$baseImage${controller.detailMovietModel.value?.posterPath}',
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: Get.height / 2,
                        ),
                        Container(
                          height: Get.height / 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0XFF000000).withOpacity(0),
                                Color(0XFF1E1E27),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          left: 32,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              Get.back();
                              print('kembali');
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Color(0XFF1E1E27),
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.detailMovietModel.value?.title}',
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${controller.detailMovietModel.value?.overview}',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                          Text(
                            'Genre',
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: controller.detailMovietModel.value != null
                                ? controller.detailMovietModel.value!.genres
                                    .map((genre) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        genre.name,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList()
                                : [], // Use an empty list if detailMovietModel is null
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                          Text(
                            'Poster',
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(child: GaleriWidget())
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
