import 'package:get/get.dart';
import '../../data/models/grocery_product_model.dart';
import '../../data/models/grocery_store_model.dart';
import '../../data/repositories/grocery_repository.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/network/api_client.dart';

class GroceryController extends GetxController {
  final _repo = GroceryRepository();

  final isLoading = false.obs;
  final stores = <GroceryStoreModel>[].obs;
  final products = <GroceryProductModel>[].obs;
  final cartItems = <GroceryProductModel, int>{}.obs;
  final groceryOrders = <Map<String, dynamic>>[].obs;

  double get subtotal => cartItems.entries
      .map((e) => e.key.price * e.value)
      .fold(0, (a, b) => a + b);

  @override
  void onInit() {
    super.onInit();
    fetchStores();
    fetchGroceryOrderHistory();
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

      final res = await _repo.getStores();
      if (res.isNotEmpty) stores.value = res;
    } on AppException catch (_) {
      // Silent fail - use demo data
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProducts(int storeId) async {
    Future.microtask(() => isLoading.value = true);
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      products.value = [
        GroceryProductModel(
          id: 1,
          name: 'Fresh Apples',
          image:
              'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?q=80&w=2074&auto=format&fit=crop',
          price: 180.0,
          unit: '1 kg',
          category: 'Fruits',
        ),
        GroceryProductModel(
          id: 2,
          name: 'Organic Milk',
          image:
              'https://images.unsplash.com/photo-1563636619-e9107b1c196e?q=80&w=1964&auto=format&fit=crop',
          price: 90.0,
          unit: '1 L',
          category: 'Dairy',
        ),
        GroceryProductModel(
          id: 3,
          name: 'Brown Bread',
          image:
              'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=2072&auto=format&fit=crop',
          price: 65.0,
          unit: '400g',
          category: 'Bakery',
        ),
        GroceryProductModel(
          id: 4,
          name: 'Farm Eggs',
          image:
              'https://images.unsplash.com/photo-1582722872445-44dc5f7e3cba?q=80&w=2070&auto=format&fit=crop',
          price: 145.0,
          unit: '12 pcs',
          category: 'Dairy',
        ),
      ];

      final res = await _repo.getProducts(storeId);
      if (res.isNotEmpty) products.value = res;
    } on AppException catch (_) {
      // Silent fail - use demo data
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGroceryOrderHistory() async {
    try {
      final res = await _repo.getGroceryOrderHistory();
      if (res.isNotEmpty) groceryOrders.value = res;
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> placeOrder(Map<String, dynamic> orderData) async {
    isLoading.value = true;
    try {
      // ── Demo Logic ─────────────────────────────────────────────────────────
      final newOrder = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'order_number': 'GROC-${DateTime.now().millisecondsSinceEpoch}',
        'items': cartItems.entries
            .map(
              (e) => {
                'name': e.key.name,
                'quantity': e.value,
                'price': e.key.price,
              },
            )
            .toList(),
        'subtotal': subtotal,
        'delivery_fee': 50,
        'total': subtotal + 50,
        'status': 'Pending',
        'date': DateTime.now().toIso8601String(),
        'address': orderData['address'],
        'payment_method': orderData['payment_method'],
      };

      groceryOrders.insert(0, newOrder);
      await _repo.placeGroceryOrder(newOrder);

      clearCart();
      Get.offNamed(AppRoutes.groceryOrderConfirmation);
    } catch (e) {
      Get.snackbar('Error', 'Failed to place order');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(GroceryProductModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
  }

  void removeFromCart(GroceryProductModel product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product] == 1) {
        cartItems.remove(product);
      } else {
        cartItems[product] = cartItems[product]! - 1;
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}
