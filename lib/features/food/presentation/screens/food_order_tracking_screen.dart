import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/food_controller.dart';

class FoodOrderTrackingScreen extends GetView<FoodController> {
  const FoodOrderTrackingScreen({super.key});

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
          _buildStatusPanel(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
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
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Arriving in 15 min',
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(24),
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
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kamrul Hasan',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Your delivery hero',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: AppColors.primary),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: AppColors.primary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const Divider(height: 32),
            _buildStatusStep(
              'Order Placed',
              'We have received your order',
              true,
              true,
            ),
            _buildStatusStep(
              'Preparing',
              'Restaurant is preparing your food',
              true,
              true,
            ),
            _buildStatusStep(
              'On the way',
              'Rider is picking up your order',
              true,
              false,
            ),
            _buildStatusStep('Delivered', 'Enjoy your meal!', false, false),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(
    String title,
    String subtitle,
    bool isCompleted,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
            if (isLast)
              Container(
                width: 2,
                height: 30,
                color: isCompleted ? AppColors.primary : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isCompleted
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
