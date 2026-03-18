import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/ride_model.dart';

class RideRepository {
  Future<List<RideTypeModel>> getRideTypes() async {
    final res = await ApiClient.get(ApiEndpoints.rideTypes);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => RideTypeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> bookRide(Map<String, dynamic> rideData) async {
    await ApiClient.post(ApiEndpoints.rideRequest, data: rideData);
  }

  Future<List<Map<String, dynamic>>> getRideHistory() async {
    final res = await ApiClient.get(
      ApiEndpoints.rideRequest,
    ); // Assuming same endpoint for history
    return (res['data'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
