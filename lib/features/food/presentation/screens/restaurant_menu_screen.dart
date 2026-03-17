import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/food_controller.dart';

class RestaurantMenuScreen extends StatefulWidget {
  const RestaurantMenuScreen({super.key});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  final controller = Get.find<FoodController>();

  @override
  void initState() {
    super.initState();
    final id = int.tryParse(Get.parameters['id'] ?? '');
    if (id != null) {
      controller.getRestaurantDetails(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();
        final restaurant = controller.selectedRestaurant.value;
        if (restaurant == null)
          return const Center(child: Text('Restaurant not found'));

        return CustomScrollView(
          slivers: [
            _buildAppBar(restaurant),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('menu'.tr, style: AppTextStyles.heading2),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _MenuItemTile(item: restaurant.menu[index]),
                childCount: restaurant.menu.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      }),
      bottomSheet: _buildCartSummary(),
    );
  }

  Widget _buildAppBar(dynamic restaurant) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          restaurant.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(restaurant.image, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: Colors.black
                    .withValues(alpha: 0.4)
                    .linearGradient(
                      Alignment.topCenter,
                      Alignment.bottomCenter,
                    ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildCartSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '2 Items | ৳770',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'plus_delivery_charge'.tr,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          TextButton(
            onPressed: () => Get.toNamed('/food/cart'),
            child: Row(
              children: [
                Text(
                  'view_cart'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final dynamic item;
  const _MenuItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '৳${item.price.toStringAsFixed(0)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -10,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('success'.tr, 'added_to_cart'.tr);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.primary,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 0,
                    ),
                    minimumSize: const Size(60, 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  child: const Text(
                    'ADD',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on Color {
  Gradient linearGradient(Alignment begin, Alignment end) =>
      LinearGradient(begin: begin, end: end, colors: [this, this]);
}
