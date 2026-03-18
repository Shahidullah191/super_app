import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/grocery_product_model.dart';
import '../models/grocery_store_model.dart';

class GroceryRepository {
  Future<List<GroceryStoreModel>> getStores() async {
    final res = await ApiClient.get(ApiEndpoints.groceryStores);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => GroceryStoreModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<GroceryProductModel>> getProducts(int storeId) async {
    final res = await ApiClient.get(ApiEndpoints.groceryProducts(storeId));
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => GroceryProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> placeGroceryOrder(Map<String, dynamic> orderData) async {
    await ApiClient.post(ApiEndpoints.groceryOrders, data: orderData);
  }

  Future<List<Map<String, dynamic>>> getGroceryOrderHistory() async {
    final res = await ApiClient.get(ApiEndpoints.groceryOrders);
    return (res['data'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
