import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/pharmacy_controller.dart';
import '../../../../app/routes/app_routes.dart';

class PharmacyCartScreen extends GetView<PharmacyController> {
  const PharmacyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('cart'.tr)),
      body: Obx(() {
        if (controller.cartItems.isEmpty &&
            controller.prescriptionImage.value == null) {
          return EmptyWidget(
            message: 'cart_empty'.tr,
            subMessage: 'cart_empty_sub'.tr,
            icon: Icons.shopping_cart_outlined,
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (controller.prescriptionImage.value != null) ...[
                    _buildPrescriptionSection(),
                    const SizedBox(height: 24),
                  ],
                  if (controller.cartItems.isNotEmpty) ...[
                    Text('medicines'.tr, style: AppTextStyles.heading3),
                    const SizedBox(height: 12),
                    ...controller.cartItems.entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _CartItemTile(
                          medicine: e.key,
                          quantity: e.value,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            _buildBottomSummary(),
          ],
        );
      }),
    );
  }

  Widget _buildPrescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'prescription'.tr,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => controller.prescriptionImage.value = null,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const CustomNetworkImage(
              image:
                  'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop', // Placeholder for uploaded image
              height: 150,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'prescription_uploaded_note'.tr,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummary() {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total'.tr, style: AppTextStyles.heading3),
                Text(
                  '৳${controller.subtotal.toStringAsFixed(2)}',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              label: 'checkout'.tr,
              onPressed: () => Get.toNamed(AppRoutes.pharmacyCheckout),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemTile extends GetView<PharmacyController> {
  final dynamic medicine;
  final int quantity;
  const _CartItemTile({required this.medicine, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomNetworkImage(
              image: medicine.image,
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '৳${medicine.price} / ${medicine.type}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: AppColors.primary,
                ),
                onPressed: () => controller.removeFromCart(medicine),
              ),
              Text(
                '$quantity',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: AppColors.primary,
                ),
                onPressed: () => controller.addToCart(medicine),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
