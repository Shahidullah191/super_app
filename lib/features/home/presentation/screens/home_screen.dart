import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildBanners(),
                  const SizedBox(height: 20),
                  Text('our_services'.tr, style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  _buildServiceGrid(),
                  const SizedBox(height: 20),
                  Text('featured'.tr, style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  _buildFeaturedList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.grid_view_rounded,
              color: AppColors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Text('Super App', style: AppTextStyles.heading2),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Get.toNamed(AppRoutes.notifications),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: controller.onSearchTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textHint, size: 20),
            const SizedBox(width: 10),
            Text('search_hint'.tr, style: AppTextStyles.hint),
          ],
        ),
      ),
    );
  }

  Widget _buildBanners() {
    return SizedBox(
      height: 160,
      child: Obx(
        () => controller.isLoading.value
            ? _shimmerBox(height: 160)
            : PageView.builder(
                controller: PageController(viewportFraction: 0.9),
                itemCount: controller.banners.isEmpty
                    ? 1
                    : controller.banners.length,
                itemBuilder: (_, i) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.campaign_rounded,
                      color: AppColors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildServiceGrid() {
    final services = [
      _ServiceItem(
        'ecommerce'.tr,
        Icons.shopping_bag_outlined,
        AppColors.ecommerce,
        AppRoutes.ecommerce,
      ),
      _ServiceItem(
        'grocery'.tr,
        Icons.local_grocery_store_outlined,
        AppColors.grocery,
        AppRoutes.groceryStoreList,
      ),
      _ServiceItem(
        'pharmacy'.tr,
        Icons.local_pharmacy_outlined,
        AppColors.pharmacy,
        AppRoutes.pharmacyMedicineList,
      ),
      _ServiceItem(
        'food'.tr,
        Icons.restaurant_outlined,
        AppColors.food,
        AppRoutes.foodRestaurantList,
      ),
      _ServiceItem(
        'ride'.tr,
        Icons.directions_car_outlined,
        AppColors.ride,
        AppRoutes.rideBooking,
      ),
      _ServiceItem(
        'courier'.tr,
        Icons.local_shipping_outlined,
        AppColors.courier,
        AppRoutes.courierBooking,
      ),
      _ServiceItem(
        'services'.tr,
        Icons.handyman_outlined,
        AppColors.onDemand,
        AppRoutes.serviceCategory,
      ),
    ];

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      childAspectRatio: 0.78,
      children: services.map((s) => _ServiceTile(service: s)).toList(),
    );
  }

  Widget _buildFeaturedList() {
    return SizedBox(
      height: 180,
      child: Obx(
        () => controller.isLoading.value
            ? _shimmerBox(height: 180)
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (_, i) => Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.store_outlined,
                      color: AppColors.textSecondary,
                      size: 40,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _shimmerBox({double height = 100}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _ServiceItem {
  final String label;
  final IconData icon;
  final Color color;
  final String route;
  _ServiceItem(this.label, this.icon, this.color, this.route);
}

class _ServiceTile extends StatelessWidget {
  final _ServiceItem service;
  const _ServiceTile({required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(service.route),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: service.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(service.icon, color: service.color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            service.label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
