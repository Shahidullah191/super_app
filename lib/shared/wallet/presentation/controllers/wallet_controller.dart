import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../data/models/wallet_model.dart';
import '../../data/repositories/wallet_repository.dart';

class WalletController extends GetxController {
  final _repo = WalletRepository();

  final wallet = Rxn<WalletModel>();
  final transactions = <TransactionModel>[].obs;
  final isLoading = false.obs;
  final isLoadingTx = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallet();
    fetchTransactions();
  }

  Future<void> fetchWallet() async {
    isLoading.value = true;
    try {
      wallet.value = await _repo.getWallet();
    } on AppException catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTransactions() async {
    isLoadingTx.value = true;
    try {
      transactions.value = await _repo.getTransactions();
    } on AppException catch (_) {
    } finally {
      isLoadingTx.value = false;
    }
  }

  Future<void> addMoney({
    required double amount,
    required String method,
  }) async {
    isLoading.value = true;
    try {
      await _repo.addMoney(amount: amount, method: method);
      await fetchWallet();
      await fetchTransactions();
      Get.back();
      Get.snackbar(
        'success'.tr,
        '৳${amount.toStringAsFixed(0)} added to wallet',
      );
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      isLoading.value = false;
    }
  }
}
