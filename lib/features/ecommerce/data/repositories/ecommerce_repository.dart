import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/product_model.dart';

class EcommerceRepository {
  Future<List<CategoryModel>> getCategories() async {
    final res = await ApiClient.get(ApiEndpoints.ecommerceCategories);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> getProducts({
    int? categoryId,
    String? search,
    int page = 1,
  }) async {
    final res = await ApiClient.get(
      ApiEndpoints.ecommerceProducts,
      queryParameters: {
        'category_id': ?categoryId,
        'search': ?search,
        'page': page,
      },
    );
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModel> getProductDetails(int id) async {
    final res = await ApiClient.get(ApiEndpoints.ecommerceProductDetails(id));
    return ProductModel.fromJson(res['data'] as Map<String, dynamic>);
  }
}
