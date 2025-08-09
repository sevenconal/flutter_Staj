import 'package:gelir_gider_app/models/app_transaction.dart';
import 'package:gelir_gider_app/models/transaction_params.dart';
import 'package:gelir_gider_app/services/api_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class TransactionRepository extends GetxService {
  late final ApiService _apiService;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
  }

  Future<List<AppTransaction>> getTransactions() async {
    final response = await _apiService.get(ApiConstants.transactions);
    if (response.statusCode == 200) {
      var gelenListe = response.data['transactions'] as List;
      return gelenListe
          .map((transaction) => AppTransaction.fromJson(transaction))
          .toList();
    }
    throw Exception("Transactionlar getirilirken hata olustu");
  }

  Future<AppTransaction> createTransaction(Transaction transaction) async {
    final response = await _apiService.post(ApiConstants.transactions,
        data: transaction.toJson());
    if (response.statusCode == 201) {
      return AppTransaction.fromJson(response.data);
    }
    throw Exception("Transaction eklenirken  hata olustu");
  }

  Future<bool> deleteTransaction(String id) async {
    final response =
        await _apiService.delete('${ApiConstants.transactions}/$id');
        print(response.data);
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception("Transaction silinemedi  hata olustu");
  }
}
