import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/storage_service.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile() async {
    final res = await ApiClient.get(ApiEndpoints.profile);
    return ProfileModel.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<ProfileModel> updateProfile({
    required String name,
    String? email,
  }) async {
    final res = await ApiClient.patch(
      ApiEndpoints.updateProfile,
      data: {'name': name, 'email': email},
    );
    return ProfileModel.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<String> uploadAvatar(String filePath) async {
    final formData = dio.FormData.fromMap({
      'avatar': await dio.MultipartFile.fromFile(filePath),
    });
    final res = await ApiClient.upload(ApiEndpoints.uploadAvatar, formData);
    return res['data']['avatar'] as String;
  }
}

class ProfileController extends GetxController {
  final _repo = ProfileRepository();

  final profile = Rxn<ProfileModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      profile.value = ProfileModel(
        id: 1,
        name: 'Shahidullah',
        phone: '01700000000',
        email: 'shahid@example.com',
        avatar:
            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({required String name, String? email}) async {
    isLoading.value = true;
    try {
      profile.value = await _repo.updateProfile(name: name, email: email);
      Get.back();
      Get.snackbar('success'.tr, 'profile_updated'.tr);
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    StorageService.clearAll();
    Get.offAllNamed('/login');
  }
}
