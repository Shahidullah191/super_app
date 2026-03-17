import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/ride_controller.dart';

class RideSearchingScreen extends GetView<RideController> {
  const RideSearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Start searching simulation
    controller.startSearching();

    return Scaffold(
      body: Stack(
        children: [
          // Mock Map
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.map, size: 100, color: Colors.grey),
            ),
          ),
          _buildSearchingOverlay(),
          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildSearchingOverlay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.radar, size: 80, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          Text(
            'Searching for nearby drivers...',
            style: AppTextStyles.heading3,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Obx(
                  () => Image.network(
                    controller.selectedRideType.value?.image ?? '',
                    height: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.selectedRideType.value?.name ?? '',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Estimated Fare: ৳150',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  foregroundColor: Colors.red,
                ),
                child: const Text('Cancel Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
