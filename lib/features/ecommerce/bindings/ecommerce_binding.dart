import 'package:get/get.dart';
import '../presentation/controllers/ecommerce_controller.dart';

class EcommerceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EcommerceController>(() => EcommerceController());
  }
}
