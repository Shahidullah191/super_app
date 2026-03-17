import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('cart'.tr),
        actions: [
          Obx(
            () => controller.cartItems.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: controller.clearCart,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return EmptyWidget(
            message: 'cart_empty'.tr,
            subMessage: 'cart_empty_sub'.tr,
            icon: Icons.shopping_cart_outlined,
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.cartItems.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) =>
                    _CartItemTile(item: controller.cartItems[index]),
              ),
            ),
            _buildSummary(),
          ],
        );
      }),
    );
  }

  Widget _buildSummary() {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('subtotal'.tr, style: AppTextStyles.bodyMedium),
                Text(
                  '৳${controller.subtotal.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('delivery_charge'.tr, style: AppTextStyles.bodyMedium),
                Text(
                  '৳${controller.deliveryCharge.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('total'.tr, style: AppTextStyles.heading3),
                Text(
                  '৳${controller.total.toStringAsFixed(2)}',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'checkout'.tr,
              onPressed: () => Get.toNamed('/checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

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
              item.product.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '৳${item.product.currentPrice.toStringAsFixed(0)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildQtyBtn(
                      Icons.remove,
                      () => controller.updateQuantity(item.product.id, -1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        item.quantity.toString(),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    _buildQtyBtn(
                      Icons.add,
                      () => controller.updateQuantity(item.product.id, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => controller.removeFromCart(item.product.id),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}
