import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/courier_controller.dart';

class CourierBookingScreen extends GetView<CourierController> {
  const CourierBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('courier_booking'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('parcel_type'.tr),
            const SizedBox(height: 12),
            _buildParcelTypeGrid(),
            const SizedBox(height: 24),
            _buildSectionTitle('sender_details'.tr),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Sender Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Sender Phone',
              prefixIcon: Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Pickup Address',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('receiver_details'.tr),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Receiver Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Receiver Phone',
              prefixIcon: Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Delivery Address',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: 'estimate_price'.tr,
              onPressed: () {
                Get.toNamed('/courier/parcel/123');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.heading3);
  }

  Widget _buildParcelTypeGrid() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemCount: controller.parcelTypes.length,
        itemBuilder: (context, index) {
          final type = controller.parcelTypes[index];
          final isSelected = controller.selectedParcelType.value?.id == type.id;
          return GestureDetector(
            onTap: () => controller.selectedParcelType.value = type,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(type.icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 4),
                  Text(
                    type.name,
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
