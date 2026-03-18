import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/ecommerce_controller.dart';

class CheckoutScreen extends GetView<EcommerceController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod = 'cod'.obs;
    final addressController = TextEditingController(
      text: '123 Main Street, Dhaka, Bangladesh',
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('checkout'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('delivery_address'.tr),
            _buildAddressCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('payment_method'.tr),
            _buildPaymentMethods(selectedPaymentMethod),
            const SizedBox(height: 24),
            _buildSectionTitle('order_summary'.tr),
            _buildOrderSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(
        selectedPaymentMethod,
        addressController,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: AppTextStyles.heading3),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: AppColors.primary),
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
                const SizedBox(height: 4),
                Text(
                  '123 Main Street, Dhaka, Bangladesh',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(AppRoutes.addressBook),
            child: Text('change'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(RxString selected) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildPaymentTile(
            'cod',
            'cash_on_delivery'.tr,
            Icons.money,
            selected,
          ),
          const Divider(height: 1),
          _buildPaymentTile(
            'wallet',
            'wallet_balance'.tr,
            Icons.account_balance_wallet_outlined,
            selected,
          ),
          const Divider(height: 1),
          _buildPaymentTile('card', 'card'.tr, Icons.credit_card, selected),
        ],
      ),
    );
  }

  Widget _buildPaymentTile(
    String value,
    String title,
    IconData icon,
    RxString selected,
  ) {
    return Obx(
      () => RadioListTile<String>(
        value: value,
        groupValue: selected.value,
        onChanged: (v) => selected.value = v!,
        title: Text(title, style: AppTextStyles.bodyMedium),
        secondary: Icon(icon, color: AppColors.textSecondary),
        activeColor: AppColors.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          ...controller.cart.value.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${item.quantity}x ${item.product.name}',
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '৳${item.total.toStringAsFixed(0)}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 24),
          _buildSummaryRow('subtotal'.tr, controller.cart.value.subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'delivery_charge'.tr,
            controller.cart.value.shipping,
          ),
          const Divider(height: 24),
          _buildSummaryRow(
            'total'.tr,
            controller.cart.value.total,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)
              : AppTextStyles.caption,
        ),
        Text(
          '৳${amount.toStringAsFixed(2)}',
          style: isBold
              ? AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                )
              : AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildBottomBar(
    RxString selectedPaymentMethod,
    TextEditingController addressController,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(
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
      ),
    );
  }
}
