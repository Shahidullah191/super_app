import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

class BannerModel {
  final int id;
  final String imageUrl;
  final String? link;
  BannerModel({required this.id, required this.imageUrl, this.link});
  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json['id'] as int,
    imageUrl: json['image_url'] as String,
    link: json['link'] as String?,
  );
}

class HomeController extends GetxController {
  final isLoading = false.obs;
  final banners = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHome();
  }

  Future<void> fetchHome() async {
    isLoading.value = true;
    try {
      final res = await ApiClient.get(ApiEndpoints.banners);
      final list = res['data'] as List? ?? [];
      banners.value = list
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on AppException catch (_) {
      // Fail silently on home – show empty state
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchTap() {
    // TODO: navigate to global search screen
  }
}
