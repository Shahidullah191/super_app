import 'package:get/get.dart';
import '../presentation/controllers/courier_controller.dart';

class CourierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourierController>(() => CourierController());
  }
}
