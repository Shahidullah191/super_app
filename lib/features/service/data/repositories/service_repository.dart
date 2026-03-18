import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/service_model.dart';

class ServiceRepository {
  Future<List<ServiceCategoryModel>> getCategories() async {
    final res = await ApiClient.get(ApiEndpoints.serviceCategories);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => ServiceCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ServiceProviderModel>> getProviders(int categoryId) async {
    final res = await ApiClient.get(ApiEndpoints.serviceProviders(categoryId));
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => ServiceProviderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> bookService(Map<String, dynamic> bookingData) async {
    await ApiClient.post(ApiEndpoints.serviceBooking, data: bookingData);
  }

  Future<List<Map<String, dynamic>>> getServiceHistory() async {
    final res = await ApiClient.get(ApiEndpoints.serviceBooking);
    return (res['data'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
