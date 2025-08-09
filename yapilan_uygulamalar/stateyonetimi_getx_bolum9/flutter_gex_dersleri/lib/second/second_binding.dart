import 'package:flutter_gex_dersleri/second/second_controller.dart';
import 'package:get/get.dart';

class SecondPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecondController>(() => SecondController());
    // Get.put<SecondController>(SecondController());
  }
}
