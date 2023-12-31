// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class DetailGallery extends StatefulWidget {
//   DetailGallery({
//     Key? key,
//     required this.currentIndex,
//     required this.images,
//     required this.title,
//   }) : super(key: key);

//   final int currentIndex;
//   final List<String> images;
//   final String title;

//   @override
//   State<DetailGallery> createState() => _DetailGalleryState();
// }

// class _DetailGalleryState extends State<DetailGallery> {
//   late PageController pageController;
//   late int selectedIndex;

//   @override
//   void initState() {
//     pageController = PageController(initialPage: widget.currentIndex);
//     selectedIndex = widget.currentIndex;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 32,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           widget.title,
//           style: GoogleFonts.montserrat(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height * 0.75,
//         child: PhotoViewGallery.builder(
//           scrollPhysics: const BouncingScrollPhysics(),
//           builder: (BuildContext context, int index) {
//             return PhotoViewGalleryPageOptions(
//               imageProvider: NetworkImage(widget.images[index]),
//               initialScale: PhotoViewComputedScale.contained * 1,
//               minScale: PhotoViewComputedScale.contained * 1,
//             );
//           },
//           itemCount: widget.images.length,
//           loadingBuilder: (context, event) => Center(
//             child: Container(
//               width: 20.0,
//               height: 20.0,
//               child: const Center(child: CircularProgressIndicator()),
//             ),
//           ),
//           pageController: pageController,
//           onPageChanged: (page) {
//             setState(() {
//               selectedIndex = page;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../controller/detail_gallery_controller.dart';

class DetailGallery extends StatelessWidget {
  DetailGallery({
    Key? key,
    required this.currentIndex,
    required this.images,
    required this.title,
  }) : super(key: key);

  final int currentIndex;
  final List<String> images;
  final String title;

  final DetailGalleryController controller = Get.put(DetailGalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(images[index]),
              initialScale: PhotoViewComputedScale.contained * 1,
              minScale: PhotoViewComputedScale.contained * 1,
            );
          },
          itemCount: images.length,
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 20.0,
              height: 20.0,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
          pageController: controller.pageController,
          onPageChanged: (page) {
            controller.selectedIndex.value = page;
          },
        ),
      ),
    );
  }
}
