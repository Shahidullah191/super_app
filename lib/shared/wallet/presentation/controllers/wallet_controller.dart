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
      // ── Demo Data ──────────────────────────────────────────────────────────
      wallet.value = WalletModel(balance: 2500.50, currency: '৳');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTransactions() async {
    isLoadingTx.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      transactions.value = [
        TransactionModel(
          id: 101,
          type: 'credit',
          amount: 500,
          description: 'Added from bKash',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        TransactionModel(
          id: 102,
          type: 'debit',
          amount: 150,
          description: 'Food Order #12345',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        TransactionModel(
          id: 103,
          type: 'credit',
          amount: 1000,
          description: 'Added from Nagad',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];
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
