import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';

class OtpVerifyScreen extends GetView<AuthController> {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final phone = args['phone'] as String? ?? '';
    final action = args['action'] as String? ?? 'register';

    final otpCtrl = PinInputController();
    final secondsLeft = AppConstants.otpResendSeconds.obs;
    Timer? timer;

    void startTimer() {
      secondsLeft.value = AppConstants.otpResendSeconds;
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (secondsLeft.value > 0) {
          secondsLeft.value--;
        } else {
          t.cancel();
        }
      });
    }

    startTimer();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.sms_outlined,
                color: AppColors.primary,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text('OTP Verification', style: AppTextStyles.heading1),
            const SizedBox(height: 10),
            Text(
              'Enter the ${AppConstants.otpLength}-digit code sent to\n$phone',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),

            // ── PIN Input
            MaterialPinField(
              length: AppConstants.otpLength,
              pinController: otpCtrl,
              keyboardType: TextInputType.number,
              theme: MaterialPinTheme(
                shape: MaterialPinShape.outlined,
                borderRadius: BorderRadius.circular(12),
                cellSize: const Size(48, 52),
                filledFillColor: AppColors.white,
                fillColor: AppColors.inputFill,
                focusedFillColor: AppColors.primaryLight,
                filledBorderColor: AppColors.primary,
                borderColor: AppColors.border,
                focusedBorderColor: AppColors.primary,
                entryAnimation: MaterialPinAnimation.fade,
              ),
              onCompleted: (otp) {
                controller.verifyOtp(phone: phone, otp: otp, action: action);
              },
              onChanged: (_) {},
            ),
            const SizedBox(height: 32),

            // ── Verify Button
            Obx(
              () => CustomButton(
                label: 'Verify OTP',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  if (otpCtrl.text.length == AppConstants.otpLength) {
                    controller.verifyOtp(
                      phone: phone,
                      otp: otpCtrl.text,
                      action: action,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 24),

            // ── Resend Timer
            Obx(
              () => secondsLeft.value > 0
                  ? Text(
                      'Resend OTP in ${secondsLeft.value}s',
                      style: AppTextStyles.bodySmall,
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.resendOtp(phone: phone);
                        startTimer();
                      },
                      child: Text(
                        'Resend OTP',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
