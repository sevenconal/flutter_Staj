import 'package:flutter_gex_dersleri/services/shared_preferences_service.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    await Get.putAsync(
      () async {
        var service = SharedPreferencesService();
        print("Shared preference service baslatılıyor ...");
        await service.init();
        print("Shared preference service başlatıldı ...");
        return service;
      },
    );
    print("3 saniye bekleniyor");
    await Future.delayed(Duration(seconds: 3));
    print("3 saniye bitti");
    Get.offAllNamed('/home');
  }
}
