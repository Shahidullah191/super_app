import 'package:get/get.dart';
import '../presentation/controllers/pharmacy_controller.dart';

class PharmacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PharmacyController>(() => PharmacyController());
  }
}
