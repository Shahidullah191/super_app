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
      // ── Demo Data ──────────────────────────────────────────────────────────
      banners.value = [
        BannerModel(
          id: 1,
          imageUrl:
              'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?q=80&w=2070&auto=format&fit=crop',
        ),
        BannerModel(
          id: 2,
          imageUrl:
              'https://images.unsplash.com/photo-1544441893-675973e31985?q=80&w=2070&auto=format&fit=crop',
        ),
        BannerModel(
          id: 3,
          imageUrl:
              'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?q=80&w=2094&auto=format&fit=crop',
        ),
      ];

      final res = await ApiClient.get(ApiEndpoints.banners);
      final list = res['data'] as List? ?? [];
      if (list.isNotEmpty) {
        banners.value = list
            .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on AppException catch (_) {
      // Fail silently on home – show demo data
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchTap() {
    // TODO: navigate to global search screen
  }
}
