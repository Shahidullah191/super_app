import 'package:get/get.dart';
import '../../data/models/grocery_store_model.dart';

class GroceryController extends GetxController {
  final isLoading = false.obs;
  final stores = <GroceryStoreModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStores();
  }

  Future<void> fetchStores() async {
    isLoading.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      stores.value = [
        GroceryStoreModel(
          id: 1,
          name: 'Fresh Mart',
          image:
              'https://images.unsplash.com/photo-1578916171728-46686eac8d58?q=80&w=1974&auto=format&fit=crop',
          address: 'Gulshan, Dhaka',
          rating: 4.8,
          deliveryTime: '20-30 min',
        ),
        GroceryStoreModel(
          id: 2,
          name: 'Daily Needs',
          image:
              'https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=2070&auto=format&fit=crop',
          address: 'Banani, Dhaka',
          rating: 4.5,
          deliveryTime: '15-25 min',
        ),
        GroceryStoreModel(
          id: 3,
          name: 'Super Saver',
          image:
              'https://images.unsplash.com/photo-1604719312563-8912e9223c6a?q=80&w=1974&auto=format&fit=crop',
          address: 'Uttara, Dhaka',
          rating: 4.2,
          deliveryTime: '30-45 min',
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }
}
