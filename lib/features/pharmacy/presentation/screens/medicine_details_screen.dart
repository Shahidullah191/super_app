import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/pharmacy_controller.dart';
import '../../data/models/medicine_model.dart';

class MedicineDetailsScreen extends GetView<PharmacyController> {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicineModel medicine = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(medicine.name),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: AppColors.white,
              child: Image.network(medicine.image, fit: BoxFit.contain),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(medicine.name, style: AppTextStyles.heading2),
                            Text(
                              medicine.genericName,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.primary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '৳${medicine.price}',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    medicine.manufacturer,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow('type'.tr, medicine.type),
                  _buildInfoRow('strength'.tr, medicine.strength),
                  const SizedBox(height: 24),
                  Text('description'.tr, style: AppTextStyles.heading3),
                  const SizedBox(height: 8),
                  Text(
                    'This medicine is used for the treatment of various conditions as prescribed by your doctor. Please follow the dosage instructions carefully.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('side_effects'.tr, style: AppTextStyles.heading3),
                  const SizedBox(height: 8),
                  Text(
                    'Common side effects may include dizziness, nausea, or headache. Consult your doctor if symptoms persist.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildQuantitySelector(medicine),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(medicine),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(MedicineModel medicine) {
    return Obx(() {
      final quantity = controller.cartItems[medicine] ?? 0;
      return Row(
        children: [
          Text('quantity'.tr, style: AppTextStyles.heading3),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: AppColors.primary),
                  onPressed: quantity > 0
                      ? () => controller.removeFromCart(medicine)
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '$quantity',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: AppColors.primary),
                  onPressed: () => controller.addToCart(medicine),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBottomBar(MedicineModel medicine) {
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
        child: CustomButton(
          label: 'add_to_cart'.tr,
          onPressed: () {
            controller.addToCart(medicine);
            Get.back();
            Get.snackbar('success'.tr, 'added_to_cart'.tr);
          },
        ),
      ),
    );
  }
}
