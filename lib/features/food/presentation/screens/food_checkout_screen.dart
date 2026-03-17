import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/food_controller.dart';

class FoodCheckoutScreen extends GetView<FoodController> {
  const FoodCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('checkout'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('delivery_address'.tr),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Home',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '123 Main St, Dhaka, Bangladesh',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text('change'.tr)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('payment_method'.tr),
            const SizedBox(height: 12),
            _buildPaymentOption(Icons.money, 'Cash on Delivery', true),
            const SizedBox(height: 8),
            _buildPaymentOption(
              Icons.account_balance_wallet_outlined,
              'Wallet',
              false,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('order_summary'.tr),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('items_total'.tr, style: AppTextStyles.bodyMedium),
                      Text(
                        '৳${controller.subtotal}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('delivery_fee'.tr, style: AppTextStyles.bodyMedium),
                      Text('৳40', style: AppTextStyles.bodyMedium),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('total_payable'.tr, style: AppTextStyles.heading3),
                      Text(
                        '৳${controller.subtotal + 40}',
                        style: AppTextStyles.heading3.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: 'place_order'.tr,
              onPressed: () {
                controller.clearCart();
                Get.offNamed('/food/tracking/123');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.heading3);
  }

  Widget _buildPaymentOption(IconData icon, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Text(label, style: AppTextStyles.bodyMedium),
          const Spacer(),
          if (isSelected)
            const Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }
}
