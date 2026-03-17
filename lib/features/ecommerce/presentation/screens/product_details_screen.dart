import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../data/models/product_model.dart';
import '../controllers/ecommerce_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final controller = Get.find<EcommerceController>();
  ProductModel? product;
  bool isLoading = true;
  int selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    final id = Get.arguments as int?;
    if (id != null) {
      product = await controller.getProductDetails(id);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Scaffold(body: LoadingWidget());
    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyWidget(
          message: 'product_not_found'.tr,
          subMessage: 'product_not_found_sub'.tr,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageGallery(),
                _buildProductInfo(),
                _buildDescription(),
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        Obx(
          () => IconButton(
            icon: Icon(
              controller.isInWishlist(product!.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: controller.isInWishlist(product!.id)
                  ? Colors.red
                  : AppColors.textPrimary,
            ),
            onPressed: () => controller.toggleWishlist(product!),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery() {
    final images = product!.gallery.isNotEmpty
        ? product!.gallery
        : [product!.image];

    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: PageView.builder(
              onPageChanged: (index) =>
                  setState(() => selectedImageIndex = index),
              itemCount: images.length,
              itemBuilder: (_, i) => Image.network(
                images[i],
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          if (images.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedImageIndex == index
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(product!.name, style: AppTextStyles.heading2),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product!.rating.toString(),
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '৳${product!.currentPrice.toStringAsFixed(0)}',
                style: AppTextStyles.heading1.copyWith(
                  color: AppColors.primary,
                ),
              ),
              if (product!.hasDiscount) ...[
                const SizedBox(width: 12),
                Text(
                  '৳${product!.price.toStringAsFixed(0)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textHint,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${((1 - product!.discountPrice! / product!.price) * 100).toStringAsFixed(0)}% OFF',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () =>
                Get.toNamed(AppRoutes.ecommerceReviews, arguments: product!.id),
            child: Text(
              '${product!.reviewCount} reviews',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('product_details'.tr, style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          Text(
            product!.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
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
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              label: 'add_to_cart'.tr,
              isOutlined: true,
              onPressed: () {
                // TODO: Add to cart
                Get.snackbar('success'.tr, 'added_to_cart'.tr);
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              label: 'buy_now'.tr,
              onPressed: () {
                // TODO: Buy now
                Get.toNamed('/checkout');
              },
            ),
          ),
        ],
      ),
    );
  }
}
