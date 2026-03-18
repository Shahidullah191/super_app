import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/restaurant_model.dart';

class FoodRepository {
  Future<List<RestaurantModel>> getRestaurants() async {
    final res = await ApiClient.get(ApiEndpoints.restaurants);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<RestaurantModel> getRestaurantMenu(int restaurantId) async {
    final res = await ApiClient.get(ApiEndpoints.restaurantMenu(restaurantId));
    return RestaurantModel.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<void> placeFoodOrder(Map<String, dynamic> orderData) async {
    await ApiClient.post(ApiEndpoints.foodOrders, data: orderData);
  }

  Future<List<Map<String, dynamic>>> getFoodOrderHistory() async {
    final res = await ApiClient.get(ApiEndpoints.foodOrders);
    return (res['data'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
