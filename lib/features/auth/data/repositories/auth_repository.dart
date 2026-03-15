import 'dart:convert';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/storage_service.dart';
import '../models/auth_models.dart';

class AuthRepository {
  Future<AuthResponseModel> register({
    required String name,
    required String phone,
    required String password,
  }) async {
    final res = await ApiClient.post(
      ApiEndpoints.register,
      data: {'name': name, 'phone': phone, 'password': password},
    );
    final model = AuthResponseModel.fromJson(res);
    await _persistSession(model);
    return model;
  }

  Future<AuthResponseModel> login({
    required String phone,
    required String password,
  }) async {
    final res = await ApiClient.post(
      ApiEndpoints.login,
      data: {'phone': phone, 'password': password},
    );
    final model = AuthResponseModel.fromJson(res);
    await _persistSession(model);
    return model;
  }

  Future<void> verifyOtp({required String phone, required String otp}) async {
    await ApiClient.post(
      ApiEndpoints.verifyOtp,
      data: {'phone': phone, 'otp': otp},
    );
  }

  Future<void> resendOtp({required String phone}) async {
    await ApiClient.post(ApiEndpoints.resendOtp, data: {'phone': phone});
  }

  Future<void> forgotPassword({required String phone}) async {
    await ApiClient.post(ApiEndpoints.forgotPassword, data: {'phone': phone});
  }

  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String password,
  }) async {
    await ApiClient.post(
      ApiEndpoints.resetPassword,
      data: {'phone': phone, 'otp': otp, 'password': password},
    );
  }

  Future<void> logout() async {
    try {
      await ApiClient.post(ApiEndpoints.logout);
    } catch (_) {}
    await StorageService.clearAll();
  }

  Future<void> _persistSession(AuthResponseModel model) async {
    await StorageService.saveToken(model.token);
    await StorageService.saveUser(jsonEncode(model.user.toJson()));
  }
}
