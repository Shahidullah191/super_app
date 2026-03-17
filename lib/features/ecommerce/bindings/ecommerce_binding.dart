import 'package:get/get.dart';
import '../presentation/controllers/cart_controller.dart';
import '../presentation/controllers/ecommerce_controller.dart';

class EcommerceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EcommerceController>(() => EcommerceController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
