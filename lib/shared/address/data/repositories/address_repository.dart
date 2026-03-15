import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/address_model.dart';

class AddressRepository {
  Future<List<AddressModel>> getAddresses() async {
    final res = await ApiClient.get(ApiEndpoints.addresses);
    final list = res['data'] as List? ?? [];
    return list
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AddressModel> addAddress(AddressModel address) async {
    final res = await ApiClient.post(
      ApiEndpoints.addAddress,
      data: address.toJson(),
    );
    return AddressModel.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<AddressModel> updateAddress(AddressModel address) async {
    final res = await ApiClient.patch(
      ApiEndpoints.updateAddress(address.id),
      data: address.toJson(),
    );
    return AddressModel.fromJson(res['data'] as Map<String, dynamic>);
  }

  Future<void> deleteAddress(int id) async {
    await ApiClient.delete(ApiEndpoints.deleteAddress(id));
  }
}
