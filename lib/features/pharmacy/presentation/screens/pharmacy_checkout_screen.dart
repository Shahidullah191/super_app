import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/pharmacy_controller.dart';

class PharmacyCheckoutScreen extends GetView<PharmacyController> {
  const PharmacyCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('checkout'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('delivery_address'.tr),
            _buildAddressCard(),
            const SizedBox(height: 24),
            if (controller.prescriptionImage.value != null) ...[
              _buildSectionTitle('Prescription'),
              _buildPrescriptionCard(),
              const SizedBox(height: 24),
            ],
            _buildSectionTitle('payment_method'.tr),
            _buildPaymentCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('order_summary'.tr),
            _buildOrderSummary(),
            const SizedBox(height: 40),
            CustomButton(
              label: 'place_order'.tr,
              onPressed: () {
                controller.clearCart();
                Get.offNamed(
                  '/order-confirmation',
                  arguments: {
                    'title': 'Order Placed Successfully!',
                    'subTitle':
                        'Your medicines will be delivered after verification.',
                  },
                );
              },
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

  Widget _buildAddressCard() {
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
        subtitle: const Text('Gulshan 2, Dhaka, Bangladesh'),
        trailing: TextButton(onPressed: () {}, child: Text('change'.tr)),
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
          child: Image.network(
            controller.prescriptionImage.value!,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(
          Icons.account_balance_wallet_outlined,
          color: AppColors.primary,
        ),
        title: const Text(
          'Wallet Balance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Available: ৳2,500.00'),
        trailing: TextButton(onPressed: () {}, child: Text('change'.tr)),
      ),
    );
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
