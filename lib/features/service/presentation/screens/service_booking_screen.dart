import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/service_controller.dart';

class ServiceBookingScreen extends GetView<ServiceController> {
  const ServiceBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Book Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Date & Time', style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Select Date',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Select Time',
              prefixIcon: Icon(Icons.access_time),
            ),
            const SizedBox(height: 24),
            Text('Problem Description', style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'Describe your problem...',
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: 'Confirm Booking',
              onPressed: () {
                Get.snackbar('Success', 'Service booking confirmed!');
                Get.offAllNamed('/main-nav');
              },
            ),
          ],
        ),
      ),
    );
  }
}
