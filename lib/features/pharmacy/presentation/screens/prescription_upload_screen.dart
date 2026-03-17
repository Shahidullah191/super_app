import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/pharmacy_controller.dart';

class PrescriptionUploadScreen extends GetView<PharmacyController> {
  const PrescriptionUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('upload_prescription'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload your prescription', style: AppTextStyles.heading2),
            const SizedBox(height: 8),
            Text(
              'Our pharmacist will review it and add the required medicines to your cart.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            Obx(
              () => GestureDetector(
                onTap: () {
                  // Simulate image picker
                  controller.uploadPrescription(
                    'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop',
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: controller.prescriptionImage.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            controller.prescriptionImage.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 48,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap to upload',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildGuidelines(),
            const SizedBox(height: 40),
            CustomButton(
              label: 'Submit Prescription',
              onPressed: () {
                if (controller.prescriptionImage.value != null) {
                  Get.snackbar(
                    'Success',
                    'Prescription uploaded successfully',
                    backgroundColor: AppColors.success,
                    colorText: Colors.white,
                  );
                  Get.back();
                } else {
                  Get.snackbar(
                    'Error',
                    'Please upload a prescription first',
                    backgroundColor: AppColors.error,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Guidelines:',
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _guidelineItem('Ensure the image is clear and readable'),
        _guidelineItem('Include patient name and date'),
        _guidelineItem('Doctor\'s signature and seal must be visible'),
        _guidelineItem('Maximum file size: 5MB'),
      ],
    );
  }

  Widget _guidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppTextStyles.bodySmall)),
        ],
      ),
    );
  }
}
