import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/ecommerce_controller.dart';

class WishlistScreen extends GetView<EcommerceController> {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('wishlist'.tr)),
      body: Obx(() {
        if (controller.wishlist.isEmpty) {
          return EmptyWidget(
            message: 'wishlist_empty'.tr,
            subMessage: 'wishlist_empty_sub'.tr,
            icon: Icons.favorite_border,
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.wishlist.length,
          itemBuilder: (_, i) {
            final product = controller.wishlist[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                    image: product.image,
                    width: 60,
                    height: 60,
                  ),
                ),
                title: Text(
                  product.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '৳${product.currentPrice.toStringAsFixed(0)}',
                  style: AppTextStyles.price.copyWith(color: AppColors.primary),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => controller.toggleWishlist(product),
                ),
                onTap: () =>
                    Get.toNamed('/product-details', arguments: product.id),
              ),
            );
          },
        );
      }),
    );
  }
}
