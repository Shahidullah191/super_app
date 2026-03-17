import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class SharedCartScreen extends StatelessWidget {
  const SharedCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('cart'.tr)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text('your_cart_is_empty'.tr, style: AppTextStyles.heading3),
            const SizedBox(height: 8),
            Text(
              'add_items_to_start_ordering'.tr,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(
                label: 'start_shopping'.tr,
                onPressed: () => Get.offAllNamed('/main-nav'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
