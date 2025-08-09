
import 'dart:math';

import 'package:flutter_gex_dersleri/services/shared_preferences_service.dart';
import 'package:get/get.dart';

class SayiController extends GetxController{
  Rx<int> randomSayi = 0.obs;

  void uret(){
    randomSayi.value = Random().nextInt(100);
  }

  @override
  void onInit() async{
    super.onInit();
    print("SayıCOntroller init");
    await _test();
  }

  _test() async{
    var sharedService = Get.find<SharedPreferencesService>();
    await sharedService.saveData('tc', "123456789");
    var okunanDeger = sharedService.getData('tc');
    print(okunanDeger);
  }

  @override
  void onClose() {
    print("SayıCOntroller onClose");
    super.onClose();
  }

  @override
  void onReady() {
     print("SayıCOntroller onReady");
    super.onReady();
  }

}