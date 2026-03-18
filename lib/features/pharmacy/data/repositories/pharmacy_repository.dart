import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/medicine_model.dart';

class PharmacyRepository {
  Future<List<MedicineModel>> getMedicines() async {
    final res = await ApiClient.get(ApiEndpoints.pharmacyMedicines);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => MedicineModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> placePharmacyOrder(Map<String, dynamic> orderData) async {
    await ApiClient.post(ApiEndpoints.pharmacyOrders, data: orderData);
  }

  Future<List<Map<String, dynamic>>> getPharmacyOrderHistory() async {
    final res = await ApiClient.get(ApiEndpoints.pharmacyOrders);
    return (res['data'] as List? ?? [])
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
