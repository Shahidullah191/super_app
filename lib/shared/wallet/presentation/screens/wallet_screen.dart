import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../data/models/wallet_model.dart';
import '../controllers/wallet_controller.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ─────────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.heroGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'wallet_balance'.tr,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white.withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(
                          () => Text(
                            '৳ ${controller.wallet.value?.balance.toStringAsFixed(2) ?? '0.00'}',
                            style: AppTextStyles.displayLarge.copyWith(
                              color: AppColors.white,
                              fontSize: 36,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                            minimumSize: const Size(160, 42),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(
                            'add_money'.tr,
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () => Get.toNamed(AppRoutes.addMoney),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text(
                'wallet'.tr,
                style: AppTextStyles.heading2.copyWith(color: AppColors.white),
              ),
              collapseMode: CollapseMode.pin,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.history, color: AppColors.white),
                tooltip: 'transaction_history'.tr,
                onPressed: () => Get.toNamed(AppRoutes.transactionHistory),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // ── Body ────────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('transaction_history'.tr, style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoadingTx.value) {
              return const SliverToBoxAdapter(child: LoadingWidget());
            }
            if (controller.transactions.isEmpty) {
              return SliverToBoxAdapter(
                child: EmptyWidget(
                  message: 'no_transactions'.tr,
                  subMessage: 'no_transactions_sub'.tr,
                  icon: Icons.account_balance_wallet_outlined,
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _TransactionTile(tx: controller.transactions[i]),
                childCount: controller.transactions.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionModel tx;
  const _TransactionTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tx.isCredit
              ? AppColors.success.withValues(alpha: 0.12)
              : AppColors.error.withValues(alpha: 0.12),
          child: Icon(
            tx.isCredit ? Icons.arrow_downward : Icons.arrow_upward,
            color: tx.isCredit ? AppColors.success : AppColors.error,
            size: 20,
          ),
        ),
        title: Text(tx.description, style: AppTextStyles.bodyMedium),
        subtitle: Text(
          '${tx.createdAt.day}/${tx.createdAt.month}/${tx.createdAt.year}',
          style: AppTextStyles.caption,
        ),
        trailing: Text(
          '${tx.isCredit ? '+' : '-'}৳${tx.amount.toStringAsFixed(0)}',
          style: AppTextStyles.price.copyWith(
            color: tx.isCredit ? AppColors.success : AppColors.error,
          ),
        ),
      ),
    );
  }
}
