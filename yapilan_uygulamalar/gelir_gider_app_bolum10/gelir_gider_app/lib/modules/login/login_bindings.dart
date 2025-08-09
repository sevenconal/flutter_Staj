
import 'package:gelir_gider_app/modules/login/login_controller.dart';
import 'package:get/instance_manager.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(),);
  }

}