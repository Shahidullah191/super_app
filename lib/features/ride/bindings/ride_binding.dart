import 'package:get/get.dart';
import '../presentation/controllers/ride_controller.dart';

class RideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideController>(() => RideController());
  }
}
