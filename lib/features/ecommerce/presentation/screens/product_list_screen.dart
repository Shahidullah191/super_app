import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/ecommerce_controller.dart';

class ProductListScreen extends GetView<EcommerceController> {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('ecommerce'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search Bar ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: controller.searchProducts,
              decoration: InputDecoration(
                hintText: 'search_products'.tr,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ── Categories ──────────────────────────────────────────────────────
          SizedBox(
            height: 40,
            child: Obx(() {
              if (controller.isCategoriesLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.categories.length + 1,
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return _CategoryChip(
                      label: 'all_products'.tr,
                      isSelected: controller.selectedCategoryId.value == null,
                      onTap: () => controller.selectCategory(null),
                    );
                  }
                  final cat = controller.categories[i - 1];
                  return _CategoryChip(
                    label: cat.name,
                    isSelected: controller.selectedCategoryId.value == cat.id,
                    onTap: () => controller.selectCategory(cat.id),
                  );
                },
              );
            }),
          ),

          const SizedBox(height: 16),

          // ── Product Grid ────────────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return const LoadingWidget();
              if (controller.products.isEmpty) {
                return EmptyWidget(
                  message: 'no_products'.tr,
                  subMessage: 'no_products_sub'.tr,
                  icon: Icons.search_off,
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.products.length,
                itemBuilder: (_, i) =>
                    _ProductCard(product: controller.products[i]),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTextStyles.label.copyWith(
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product; // ProductModel
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/product-details', arguments: product.id),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.inputFill,
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '৳${product.currentPrice.toStringAsFixed(0)}',
                        style: AppTextStyles.price.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 8),
                        Text(
                          '৳${product.price.toStringAsFixed(0)}',
                          style: AppTextStyles.caption.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
