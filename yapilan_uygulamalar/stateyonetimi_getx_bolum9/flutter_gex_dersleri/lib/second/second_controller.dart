import 'package:get/get.dart';

class SecondController extends GetxController {
  var name = 'emre'.obs;
  @override
  void onInit() {
    super.onInit();
    print("Second page controller init");
  }

  @override
  void onReady() {
    super.onReady();
    print("Second page controller onReady");
  }

  @override
  void onClose() {
    super.onClose();
    print("Second page controller onClose");
  }

  void degistir(){
    name.value = 'yeni emre';
  }

}