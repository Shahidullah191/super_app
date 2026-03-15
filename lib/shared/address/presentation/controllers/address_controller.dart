import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../data/models/address_model.dart';
import '../../data/repositories/address_repository.dart';

class AddressController extends GetxController {
  final _repo = AddressRepository();

  final addresses = <AddressModel>[].obs;
  final isLoading = false.obs;
  final selectedAddress = Rxn<AddressModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    try {
      addresses.value = await _repo.getAddresses();
      selectedAddress.value =
          addresses.firstWhereOrNull((a) => a.isDefault) ??
          addresses.firstOrNull;
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      final added = await _repo.addAddress(address);
      addresses.add(added);
      Get.back();
      Get.snackbar('success'.tr, 'address_added'.tr);
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      await _repo.deleteAddress(id);
      addresses.removeWhere((a) => a.id == id);
      Get.snackbar('success'.tr, 'address_deleted'.tr);
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    }
  }

  void selectAddress(AddressModel address) {
    selectedAddress.value = address;
    Get.back();
  }
}
