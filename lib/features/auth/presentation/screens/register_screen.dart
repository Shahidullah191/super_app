import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Join Us Today', style: AppTextStyles.displayMedium),
                const SizedBox(height: 6),
                Text(
                  'Create your account to get started',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),

                // ── Name
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  controller: nameCtrl,
                  prefixIcon: const Icon(Icons.person_outline, size: 20),
                  validator: AppValidators.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

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
                  hint: 'Min. 6 characters',
                  controller: passCtrl,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  validator: AppValidators.password,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // ── Confirm Password
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: confirmPassCtrl,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  validator: (v) =>
                      AppValidators.confirmPassword(v, passCtrl.text),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),

                // ── Register Button
                Obx(
                  () => CustomButton(
                    label: 'Create Account',
                    isLoading: controller.isLoading.value,
                    onPressed: () {

                      Get.offAllNamed(AppRoutes.mainNav);

                      /*if (formKey.currentState!.validate()) {
                        controller.register(
                          name: nameCtrl.text.trim(),
                          phone: phoneCtrl.text.trim(),
                          password: passCtrl.text.trim(),
                        );
                      }*/
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // ── Login Link
                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.login),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
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
