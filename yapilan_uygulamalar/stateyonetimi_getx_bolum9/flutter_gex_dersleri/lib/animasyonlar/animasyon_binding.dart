import 'package:flutter_gex_dersleri/animasyonlar/animasyon_controller.dart';
import 'package:get/get.dart';

class AnimasyonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AnimasyonController(),
    );
  }
}
