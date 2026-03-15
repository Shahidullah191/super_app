import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/wallet_model.dart';

class WalletRepository {
  Future<WalletModel> getWallet() async {
    final res = await ApiClient.get(ApiEndpoints.walletBalance);
    return WalletModel.fromJson(res);
  }

  Future<void> addMoney({
    required double amount,
    required String method,
  }) async {
    await ApiClient.post(
      ApiEndpoints.addMoney,
      data: {'amount': amount, 'method': method},
    );
  }

  Future<List<TransactionModel>> getTransactions({int page = 1}) async {
    final res = await ApiClient.get(
      ApiEndpoints.transactions,
      queryParameters: {'page': page},
    );
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
