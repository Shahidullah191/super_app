import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/food_controller.dart';
import '../../../../app/routes/app_routes.dart';

class FoodCheckoutScreen extends GetView<FoodController> {
  const FoodCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod = 'cod'.obs;
    final addressController = TextEditingController(
      text: '123 Main St, Gulshan 2, Dhaka',
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('checkout'.tr)),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('delivery_address'.tr),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Home',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          addressController.text,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.addressBook),
                    child: Text(
                      'change'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('payment_method'.tr),
            const SizedBox(height: 12),
            _buildPaymentOption(
              Icons.money_rounded,
              'cod',
              'cash_on_delivery'.tr,
              selectedPaymentMethod,
            ),
            const SizedBox(height: 12),
            _buildPaymentOption(
              Icons.account_balance_wallet_rounded,
              'wallet',
              'wallet_balance'.tr,
              selectedPaymentMethod,
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('order_summary'.tr),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow('items_total'.tr, '৳${controller.subtotal}'),
                  const SizedBox(height: 12),
                  _buildSummaryRow('delivery_fee'.tr, '৳40'),
                  const Divider(height: 32),
                  _buildSummaryRow(
                    'total_payable'.tr,
                    '৳${controller.subtotal + 40}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Obx(
              () => CustomButton(
                label: 'place_order'.tr,
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.placeOrder({
                    'payment_method': selectedPaymentMethod.value,
                    'address': addressController.text,
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.heading3);
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal ? AppTextStyles.heading3 : AppTextStyles.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.heading3.copyWith(color: AppColors.primary)
              : AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    IconData icon,
    String value,
    String label,
    RxString selected,
  ) {
    return Obx(() {
      final isSelected = selected.value == value;
      return GestureDetector(
        onTap: () => selected.value = value,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      );
    });
  }
}
