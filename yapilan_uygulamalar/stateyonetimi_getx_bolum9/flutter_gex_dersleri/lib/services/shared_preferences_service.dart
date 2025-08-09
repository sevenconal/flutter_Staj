
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService  extends GetxService{
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  Future<void> saveData(String key, String value) async{
    await _preferences.setString(key, value);
  }
  String? getData(String key){
    return _preferences.getString(key);
  }
}