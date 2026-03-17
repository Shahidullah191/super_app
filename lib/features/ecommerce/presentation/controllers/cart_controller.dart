import 'package:get/get.dart';
import '../../data/models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.currentPrice * quantity;
}

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryCharge => cartItems.isEmpty ? 0 : 50.0;
  double get total => subtotal + deliveryCharge;

  void addToCart(ProductModel product) {
    final existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );
    if (existingItem != null) {
      existingItem.quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }
    Get.snackbar('success'.tr, 'added_to_cart'.tr);
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(int productId, int delta) {
    final item = cartItems.firstWhereOrNull(
      (item) => item.product.id == productId,
    );
    if (item != null) {
      item.quantity += delta;
      if (item.quantity <= 0) {
        removeFromCart(productId);
      } else {
        cartItems.refresh();
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }
}
