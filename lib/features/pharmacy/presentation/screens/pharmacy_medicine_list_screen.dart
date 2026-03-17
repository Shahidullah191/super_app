import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/pharmacy_controller.dart';

class PharmacyMedicineListScreen extends GetView<PharmacyController> {
  const PharmacyMedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('pharmacy_medicines'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () {
              // TODO: Upload prescription
              Get.snackbar('info'.tr, 'prescription_upload_coming_soon'.tr);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();
        if (controller.medicines.isEmpty) {
          return EmptyWidget(
            message: 'no_medicines'.tr,
            subMessage: 'no_medicines_sub'.tr,
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.medicines.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _MedicineCard(medicine: controller.medicines[index]),
        );
      }),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  final dynamic medicine;
  const _MedicineCard({required this.medicine});

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
            child: Image.network(
              medicine.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
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
                  '${medicine.genericName} - ${medicine.strength}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  medicine.manufacturer,
                  style: AppTextStyles.caption.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳${medicine.price.toStringAsFixed(2)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // TODO: Add to cart
                  Get.snackbar('success'.tr, 'added_to_cart'.tr);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  minimumSize: const Size(60, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
