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
    final dateController = TextEditingController();
    final timeController = TextEditingController();
    final descriptionController = TextEditingController();

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
            CustomTextField(
              hint: 'Select Date',
              controller: dateController,
              prefixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) {
                  dateController.text = date.toIso8601String().split('T')[0];
                }
              },
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hint: 'Select Time',
              controller: timeController,
              prefixIcon: const Icon(Icons.access_time),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  timeController.text = time.format(context);
                }
              },
            ),
            const SizedBox(height: 24),
            Text('Problem Description', style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            CustomTextField(
              hint: 'Describe your problem...',
              controller: descriptionController,
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            Obx(
              () => CustomButton(
                label: 'Confirm Booking',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.bookService({
                    'date': dateController.text,
                    'time': timeController.text,
                    'description': descriptionController.text,
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
