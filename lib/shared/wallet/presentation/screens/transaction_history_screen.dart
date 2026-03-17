import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/wallet_controller.dart';

class TransactionHistoryScreen extends GetView<WalletController> {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('transaction_history'.tr)),
      body: Obx(() {
        if (controller.isLoadingTx.value) return const LoadingWidget();
        if (controller.transactions.isEmpty) {
          return EmptyWidget(
            message: 'no_transactions'.tr,
            subMessage: 'no_transactions_sub'.tr,
            icon: Icons.receipt_long_outlined,
          );
        }
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.fetchTransactions,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.transactions.length,
            itemBuilder: (_, i) {
              final tx = controller.transactions[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: tx.isCredit
                        ? AppColors.success.withValues(alpha: 0.12)
                        : AppColors.error.withValues(alpha: 0.12),
                    child: Icon(
                      tx.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                      color: tx.isCredit ? AppColors.success : AppColors.error,
                      size: 18,
                    ),
                  ),
                  title: Text(tx.description, style: AppTextStyles.bodyMedium),
                  subtitle: Text(
                    '${tx.createdAt.day}/${tx.createdAt.month}/${tx.createdAt.year}  ${tx.createdAt.hour}:${tx.createdAt.minute.toString().padLeft(2, '0')}',
                    style: AppTextStyles.caption,
                  ),
                  trailing: Text(
                    '${tx.isCredit ? '+' : '-'}৳${tx.amount.toStringAsFixed(0)}',
                    style: AppTextStyles.price.copyWith(
                      color: tx.isCredit ? AppColors.success : AppColors.error,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
