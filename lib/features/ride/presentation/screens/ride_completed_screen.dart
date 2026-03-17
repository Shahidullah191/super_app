import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/ride_controller.dart';

class RideCompletedScreen extends GetView<RideController> {
  const RideCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              Text('ride_completed'.tr, style: AppTextStyles.displayMedium),
              const SizedBox(height: 8),
              Text(
                'hope_you_had_a_great_ride'.tr,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('total_fare'.tr, style: AppTextStyles.bodyLarge),
                        Text(
                          '৳450',
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      Icons.location_on_outlined,
                      'Pickup',
                      'Gulshan 2, Dhaka',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.flag_outlined,
                      'Drop-off',
                      'Banani, Dhaka',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text('rate_your_driver'.tr, style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                label: 'back_to_home'.tr,
                onPressed: () => Get.offAllNamed('/main-nav'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
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
                value,
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
