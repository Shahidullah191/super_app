import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/wallet_controller.dart';

class AddMoneyScreen extends GetView<WalletController> {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amountCtrl = TextEditingController();
    final selectedMethod = 'mobile_banking'.obs;
    final methods = [
      _PayMethod(
        'mobile_banking',
        Icons.phone_android_outlined,
        'mobile_banking'.tr,
      ),
      _PayMethod('card', Icons.credit_card_outlined, 'card'.tr),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('topup_wallet'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Amount ──────────────────────────────────────────────────────
            Text('enter_amount'.tr, style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text(
                    '৳',
                    style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: amountCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      style: AppTextStyles.displayMedium,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '0.00',
                        hintStyle: AppTextStyles.displayMedium.copyWith(
                          color: AppColors.border,
                        ),
                        filled: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Quick amounts
            Wrap(
              spacing: 8,
              children: [100, 200, 500, 1000]
                  .map(
                    (v) => ActionChip(
                      label: Text('৳$v'),
                      onPressed: () => amountCtrl.text = v.toString(),
                      backgroundColor: AppColors.primaryLight,
                      labelStyle: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),

            // ── Payment Method ────────────────────────────────────────────────
            Text('payment_method'.tr, style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            Obx(
              () => Column(
                children: methods
                    .map(
                      (m) => RadioListTile<String>(
                        value: m.key,
                        groupValue: selectedMethod.value,
                        onChanged: (v) => selectedMethod.value = v!,
                        title: Row(
                          children: [
                            Icon(m.icon, size: 20, color: AppColors.primary),
                            const SizedBox(width: 10),
                            Text(m.label, style: AppTextStyles.bodyMedium),
                          ],
                        ),
                        activeColor: AppColors.primary,
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),

            // ── Action ────────────────────────────────────────────────────────
            Obx(
              () => CustomButton(
                label: 'add_money'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text);
                  if (amount == null || amount <= 0) {
                    Get.snackbar('error'.tr, 'enter_amount'.tr);
                    return;
                  }
                  controller.addMoney(
                    amount: amount,
                    method: selectedMethod.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PayMethod {
  final String key;
  final IconData icon;
  final String label;
  _PayMethod(this.key, this.icon, this.label);
}
