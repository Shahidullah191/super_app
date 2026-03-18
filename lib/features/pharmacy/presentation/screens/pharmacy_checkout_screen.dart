import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../controllers/pharmacy_controller.dart';

class PharmacyCheckoutScreen extends GetView<PharmacyController> {
  const PharmacyCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPaymentMethod = 'cod'.obs;
    final addressController = TextEditingController(
      text: 'Gulshan 2, Dhaka, Bangladesh',
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('checkout'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('delivery_address'.tr),
            _buildAddressCard(addressController),
            const SizedBox(height: 24),
            if (controller.prescriptionImage.value != null) ...[
              _buildSectionTitle('Prescription'),
              _buildPrescriptionCard(),
              const SizedBox(height: 24),
            ],
            _buildSectionTitle('payment_method'.tr),
            _buildPaymentMethods(selectedPaymentMethod),
            const SizedBox(height: 24),
            _buildSectionTitle('order_summary'.tr),
            _buildOrderSummary(),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAddressCard(TextEditingController addressController) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(
          Icons.location_on_outlined,
          color: AppColors.primary,
        ),
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(addressController.text),
        trailing: TextButton(
          onPressed: () => Get.toNamed(AppRoutes.addressBook),
          child: Text('change'.tr),
        ),
      ),
    );
  }

  Widget _buildPrescriptionCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(
          Icons.description_outlined,
          color: AppColors.primary,
        ),
        title: const Text(
          'Prescription Uploaded',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Our pharmacist will review it.'),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: const CustomNetworkImage(
            image:
                'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop',
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods(RxString selected) {
    return Column(
      children: [
        _buildPaymentOption(
          Icons.money_rounded,
          'cod',
          'cash_on_delivery'.tr,
          selected,
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          Icons.account_balance_wallet_rounded,
          'wallet',
          'wallet_balance'.tr,
          selected,
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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            title: Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: AppColors.primary)
                : null,
          ),
        ),
      );
    });
  }

  Widget _buildOrderSummary() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryRow('items_total'.tr, '৳${controller.subtotal}'),
            _summaryRow('delivery_fee'.tr, '৳40.00'),
            const Divider(height: 24),
            _summaryRow(
              'total_payable'.tr,
              '৳${controller.subtotal + 40}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)
                : AppTextStyles.bodyMedium,
          ),
          Text(
            value,
            style: isTotal
                ? AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  )
                : AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
