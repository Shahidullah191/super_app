import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/parcel_model.dart';

class CourierRepository {
  Future<List<ParcelTypeModel>> getParcelTypes() async {
    final res = await ApiClient.get(
      ApiEndpoints.serviceCategories,
    ); // Using serviceCategories as a placeholder if courierTypes not available
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => ParcelTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> bookCourier(Map<String, dynamic> courierData) async {
    await ApiClient.post(ApiEndpoints.courierBook, data: courierData);
  }

  Future<List<Map<String, dynamic>>> getCourierHistory() async {
    final res = await ApiClient.get(
      ApiEndpoints.courierBook,
    ); // Assuming same endpoint for history
    return (res['data'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
