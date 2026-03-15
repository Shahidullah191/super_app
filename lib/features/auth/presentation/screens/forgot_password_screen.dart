import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final step = args['step'] as String? ?? 'phone';
    final phone = args['phone'] as String? ?? '';
    final otp = args['otp'] as String? ?? '';

    // Step 1: phone entry
    // Step 2: password reset (after OTP verified)
    if (step == 'reset') {
      return _ResetPasswordView(phone: phone, otp: otp);
    }
    return _ForgotPhoneView();
  }
}

class _ForgotPhoneView extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();

  _ForgotPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.lock_reset,
                  color: AppColors.primary,
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),
              Text('Reset Password', style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text(
                'Enter your registered phone number. We\'ll send an OTP to verify.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Phone Number',
                hint: '+880 1X XX XX XX XX',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                validator: AppValidators.phone,
              ),
              const SizedBox(height: 28),
              Obx(
                () => CustomButton(
                  label: 'Send OTP',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.forgotPassword(phone: _phoneCtrl.text.trim());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResetPasswordView extends GetView<AuthController> {
  final String phone;
  final String otp;

  const _ResetPasswordView({required this.phone, required this.otp});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Set New Password'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('New Password', style: AppTextStyles.heading1),
              const SizedBox(height: 8),
              Text(
                'Create a strong password for your account.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'New Password',
                hint: 'Min. 6 characters',
                controller: passCtrl,
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                validator: AppValidators.password,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                hint: 'Re-enter password',
                controller: confirmCtrl,
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                validator: (v) =>
                    AppValidators.confirmPassword(v, passCtrl.text),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  label: 'Reset Password',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.resetPassword(
                        phone: phone,
                        otp: otp,
                        password: passCtrl.text.trim(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
