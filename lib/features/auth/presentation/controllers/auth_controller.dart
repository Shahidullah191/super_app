import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/network/api_client.dart';
import '../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final _repo = AuthRepository();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // ── Register ──────────────────────────────────────────────────────────────
  Future<void> register({
    required String name,
    required String phone,
    required String password,
  }) async {
    _start();
    try {
      await _repo.register(name: name, phone: phone, password: password);
      Get.toNamed(
        AppRoutes.otpVerify,
        arguments: {'phone': phone, 'action': 'register'},
      );
    } on AppException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar('error'.tr, e.message);
    } finally {
      _stop();
    }
  }

  // ── Login ─────────────────────────────────────────────────────────────────
  Future<void> login({required String phone, required String password}) async {
    _start();
    try {
      await _repo.login(phone: phone, password: password);
      Get.offAllNamed(AppRoutes.mainNav);
    } on AppException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar('error'.tr, e.message);
    } finally {
      _stop();
    }
  }

  // ── OTP Verify ────────────────────────────────────────────────────────────
  Future<void> verifyOtp({
    required String phone,
    required String otp,
    String action = 'register',
  }) async {
    _start();
    try {
      await _repo.verifyOtp(phone: phone, otp: otp);
      if (action == 'forgot') {
        Get.toNamed(
          AppRoutes.forgotPassword,
          arguments: {'phone': phone, 'otp': otp, 'step': 'reset'},
        );
      } else {
        Get.offAllNamed(AppRoutes.mainNav);
      }
    } on AppException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar('error'.tr, e.message);
    } finally {
      _stop();
    }
  }

  // ── Resend OTP ────────────────────────────────────────────────────────────
  Future<void> resendOtp({required String phone}) async {
    _start();
    try {
      await _repo.resendOtp(phone: phone);
      Get.snackbar('success'.tr, 'resend_otp'.tr);
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      _stop();
    }
  }

  // ── Forgot Password ───────────────────────────────────────────────────────
  Future<void> forgotPassword({required String phone}) async {
    _start();
    try {
      await _repo.forgotPassword(phone: phone);
      Get.toNamed(
        AppRoutes.otpVerify,
        arguments: {'phone': phone, 'action': 'forgot'},
      );
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      _stop();
    }
  }

  // ── Reset Password ────────────────────────────────────────────────────────
  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String password,
  }) async {
    _start();
    try {
      await _repo.resetPassword(phone: phone, otp: otp, password: password);
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar('success'.tr, 'password_reset_success'.tr);
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      _stop();
    }
  }

  // ── Logout ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await _repo.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  void _start() {
    isLoading.value = true;
    errorMessage.value = '';
  }

  void _stop() => isLoading.value = false;
}
