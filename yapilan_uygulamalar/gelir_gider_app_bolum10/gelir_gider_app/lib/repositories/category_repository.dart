import 'package:gelir_gider_app/models/app_category.dart';
import 'package:gelir_gider_app/services/api_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class CategoryRepository extends GetxService {
  late final ApiService _apiService;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppCategory>> getCategories() async {
    final response = await _apiService.get(ApiConstants.categories);
    if (response.statusCode == 200) {
      var gelenListe = response.data as List;
     
      return gelenListe
          .map((category) => AppCategory.fromJson(category))
          .toList();
    }
    throw Exception("Kategoriler getirilirken bir hata olustu");
  }

  Future<AppCategory> createCategory(AppCategory category) async {
    final response = await _apiService.post(ApiConstants.categories,
        data: category.toJson());
    if (response.statusCode == 201) {
      return AppCategory.fromJson(response.data);
    }
    throw Exception("Kategori eklenirken  bir hata olustu");
  }
}
