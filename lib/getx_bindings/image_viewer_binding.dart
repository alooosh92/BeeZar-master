import 'package:beezar/modules/Screens/image_viewer/image_viewer_controller.dart';
import 'package:get/get.dart';

class ImageViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ImageViewerController>(ImageViewerController(), permanent: false);
  }
}
