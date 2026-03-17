import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/ecommerce_controller.dart';

class ProductReviewsScreen extends GetView<EcommerceController> {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = Get.arguments as int?;
    if (productId != null) {
      controller.fetchReviews(productId);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('reviews'.tr)),
      body: Obx(() {
        if (controller.reviews.isEmpty) {
          return Center(child: Text('no_reviews'.tr));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reviews.length,
          separatorBuilder: (_, __) => const Divider(height: 32),
          itemBuilder: (_, i) {
            final review = controller.reviews[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.userName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      review.date,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  review.comment,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
