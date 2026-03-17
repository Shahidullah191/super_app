import 'package:get/get.dart';
import '../../data/models/restaurant_model.dart';
import '../../../../app/routes/app_routes.dart';

class FoodController extends GetxController {
  final isLoading = false.obs;
  final restaurants = <RestaurantModel>[].obs;
  final selectedRestaurant = Rxn<RestaurantModel>();
  final cartItems = <MenuItemModel, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRestaurants();
  }

  Future<void> fetchRestaurants() async {
    Future.microtask(() => isLoading.value = true);
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      restaurants.value = [
        RestaurantModel(
          id: 1,
          name: 'Burger King',
          image:
              'https://images.unsplash.com/photo-1571091718767-18b5b1457add?q=80&w=2072&auto=format&fit=crop',
          address: 'Gulshan 2, Dhaka',
          rating: 4.5,
          deliveryTime: '25-35 min',
          cuisines: ['Burgers', 'Fast Food', 'American'],
          menu: _getDemoMenu(1),
        ),
        RestaurantModel(
          id: 2,
          name: 'Pizza Hut',
          image:
              'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=2070&auto=format&fit=crop',
          address: 'Banani, Dhaka',
          rating: 4.2,
          deliveryTime: '30-40 min',
          cuisines: ['Pizza', 'Italian', 'Fast Food'],
          menu: _getDemoMenu(2),
        ),
        RestaurantModel(
          id: 3,
          name: 'Sultan\'s Dine',
          image:
              'https://images.unsplash.com/photo-1589302168068-964664d93dc0?q=80&w=1974&auto=format&fit=crop',
          address: 'Dhanmondi, Dhaka',
          rating: 4.8,
          deliveryTime: '40-50 min',
          cuisines: ['Kacchi', 'Biryani', 'Bengali'],
          menu: _getDemoMenu(3),
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  List<MenuItemModel> _getDemoMenu(int restaurantId) {
    if (restaurantId == 1) {
      return [
        MenuItemModel(
          id: 101,
          name: 'Whopper Junior',
          description:
              'Flame-grilled beef patty with fresh lettuce, tomatoes, and onions.',
          price: 350,
          image:
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1899&auto=format&fit=crop',
          category: 'Burgers',
        ),
        MenuItemModel(
          id: 102,
          name: 'Chicken Royale',
          description:
              'Crispy chicken patty with creamy mayo and fresh lettuce.',
          price: 420,
          image:
              'https://images.unsplash.com/photo-1610614819513-58e34989848b?q=80&w=2070&auto=format&fit=crop',
          category: 'Burgers',
        ),
      ];
    } else if (restaurantId == 2) {
      return [
        MenuItemModel(
          id: 201,
          name: 'Margherita Pizza',
          description:
              'Classic pizza with tomato sauce, mozzarella, and basil.',
          price: 850,
          image:
              'https://images.unsplash.com/photo-1574071318508-1cdbad80ad50?q=80&w=2070&auto=format&fit=crop',
          category: 'Pizza',
        ),
        MenuItemModel(
          id: 202,
          name: 'Pepperoni Feast',
          description: 'Loaded with pepperoni and extra mozzarella cheese.',
          price: 1200,
          image:
              'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=2080&auto=format&fit=crop',
          category: 'Pizza',
        ),
      ];
    }
    return [];
  }

  void addToCart(MenuItemModel item) {
    if (cartItems.containsKey(item)) {
      cartItems[item] = cartItems[item]! + 1;
    } else {
      cartItems[item] = 1;
    }
  }

  void removeFromCart(MenuItemModel item) {
    if (cartItems.containsKey(item)) {
      if (cartItems[item] == 1) {
        cartItems.remove(item);
      } else {
        cartItems[item] = cartItems[item]! - 1;
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  double get subtotal => cartItems.entries
      .map((e) => e.key.price * e.value)
      .fold(0, (a, b) => a + b);

  int get totalItems => cartItems.values.fold(0, (a, b) => a + b);

  Future<void> getRestaurantDetails(int id) async {
    Future.microtask(() => isLoading.value = true);
    try {
      selectedRestaurant.value = restaurants.firstWhereOrNull(
        (r) => r.id == id,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void placeOrder() {
    clearCart();
    Get.offNamed(AppRoutes.foodOrderTracking.replaceAll(':id', '123'));
  }
}
