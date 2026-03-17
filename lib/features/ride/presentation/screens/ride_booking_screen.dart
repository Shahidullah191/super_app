import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/ride_controller.dart';

class RideBookingScreen extends GetView<RideController> {
  const RideBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          _buildTopBar(),
          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildLocationRow(
                    Icons.my_location,
                    AppColors.primary,
                    controller.pickupAddress.value,
                  ),
                  const Divider(height: 24),
                  _buildLocationRow(Icons.location_on, Colors.red, 'Where to?'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: text == 'Where to?'
                  ? AppColors.textSecondary
                  : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Ride', style: AppTextStyles.heading3),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: Obx(
                () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.rideTypes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final type = controller.rideTypes[index];
                    final isSelected =
                        controller.selectedRideType.value?.id == type.id;
                    return GestureDetector(
                      onTap: () => controller.selectedRideType.value = type,
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryLight
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(type.image, height: 40),
                            const SizedBox(height: 8),
                            Text(
                              type.name,
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '৳${type.baseFare}',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Book Ride',
              onPressed: () => Get.toNamed('/ride/searching'),
            ),
          ],
        ),
      ),
    );
  }
}
