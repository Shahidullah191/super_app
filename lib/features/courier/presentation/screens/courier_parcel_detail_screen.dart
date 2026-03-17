import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/courier_controller.dart';

class CourierParcelDetailScreen extends GetView<CourierController> {
  const CourierParcelDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('parcel_details'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('parcel_summary'.tr),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'parcel_type'.tr,
                    controller.selectedParcelType.value?.name ?? 'Document',
                  ),
                  const Divider(height: 24),
                  _buildSummaryRow('weight'.tr, 'Up to 1 kg'),
                  const Divider(height: 24),
                  _buildSummaryRow('estimated_price'.tr, '৳120', isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('delivery_route'.tr),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildRouteRow(
                    Icons.radio_button_checked,
                    AppColors.primary,
                    'Pickup',
                    'Gulshan 2, Dhaka',
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: AppColors.border,
                    margin: const EdgeInsets.only(left: 9),
                  ),
                  _buildRouteRow(
                    Icons.location_on,
                    Colors.red,
                    'Delivery',
                    'Banani, Dhaka',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: 'confirm_booking'.tr,
              onPressed: () => Get.offNamed('/courier/tracking/123'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.heading3);
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildRouteRow(
    IconData icon,
    Color color,
    String label,
    String address,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                address,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
