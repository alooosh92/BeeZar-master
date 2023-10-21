import 'package:beezar/constants.dart';
import 'package:beezar/modules/Screens/image_viewer/image_viewer_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageViewer extends StatelessWidget {
  ImageViewerController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            //  Get.back();
          },
          child: Container(
            color: Colors.white.withOpacity(0.2),
            child: Center(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: ClipRRect(
                  child: InteractiveViewer(
                    maxScale: 5.0,
                    minScale: 0.05,
                    child: CachedNetworkImage(
                      imageUrl: "${controller.image}",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
