import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/grocery_controller.dart';
import '../../data/models/grocery_product_model.dart';

class GroceryProductDetailsScreen extends GetView<GroceryController> {
  const GroceryProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroceryProductModel product = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
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
                            Text(product.name, style: AppTextStyles.heading2),
                            Text(
                              '${product.unit} • ${product.category}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '৳${product.price}',
                        style: AppTextStyles.heading2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('description'.tr, style: AppTextStyles.heading3),
                  const SizedBox(height: 8),
                  Text(
                    'Fresh and high-quality ${product.name.toLowerCase()} sourced directly from local farms. Perfect for your daily needs.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildQuantitySelector(product),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(product),
    );
  }

  Widget _buildQuantitySelector(GroceryProductModel product) {
    return Obx(() {
      final quantity = controller.cartItems[product] ?? 0;
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
                      ? () => controller.removeFromCart(product)
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
                  onPressed: () => controller.addToCart(product),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBottomBar(GroceryProductModel product) {
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
            controller.addToCart(product);
            Get.back();
            Get.snackbar('success'.tr, 'added_to_cart'.tr);
          },
        ),
      ),
    );
  }
}
