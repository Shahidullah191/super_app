import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final phoneCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // ── Logo / brand
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.grid_view_rounded,
                      color: AppColors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Welcome Back!', style: AppTextStyles.displayMedium),
                const SizedBox(height: 6),
                Text(
                  'Sign in to continue',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 36),

                // ── Phone
                CustomTextField(
                  label: 'Phone Number',
                  hint: '+880 1X XX XX XX XX',
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                  validator: AppValidators.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // ── Password
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: passCtrl,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  validator: AppValidators.password,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 12),

                // ── Forgot
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Login Button
                Obx(
                  () => CustomButton(
                    label: 'Login',
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      
                      Get.toNamed(AppRoutes.mainNav);

                      /*if (formKey.currentState!.validate()) {
                        controller.login(
                          phone: phoneCtrl.text.trim(),
                          password: passCtrl.text.trim(),
                        );
                      }*/
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // ── Register Link
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.register),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
