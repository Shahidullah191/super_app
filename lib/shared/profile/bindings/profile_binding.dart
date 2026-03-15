import 'package:get/get.dart';
import '../data/repositories/profile_repository.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
