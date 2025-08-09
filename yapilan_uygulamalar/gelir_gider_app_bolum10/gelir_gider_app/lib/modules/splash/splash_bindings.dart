import 'package:gelir_gider_app/modules/splash/splash_controller.dart';
import 'package:get/instance_manager.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
