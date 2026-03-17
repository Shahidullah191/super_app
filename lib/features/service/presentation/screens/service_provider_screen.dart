import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/service_controller.dart';

class ServiceProviderScreen extends GetView<ServiceController> {
  const ServiceProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Obx(
          () => Text(controller.selectedCategory.value?.name ?? 'Providers'),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value)
          return const Center(child: CircularProgressIndicator());
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.providers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final provider = controller.providers[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      provider.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.name,
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              provider.rating.toString(),
                              style: AppTextStyles.caption,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              provider.experience,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Starts from ৳${provider.startingPrice}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/service/booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Book'),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
