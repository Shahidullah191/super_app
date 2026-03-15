import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../data/repositories/profile_repository.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(
      text: controller.profile.value?.name,
    );
    final emailCtrl = TextEditingController(
      text: controller.profile.value?.email,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter your name',
                controller: nameCtrl,
                prefixIcon: const Icon(Icons.person_outline, size: 20),
                validator: AppValidators.name,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email (optional)',
                hint: 'Enter your email',
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
              ),
              const SizedBox(height: 32),
              Obx(
                () => CustomButton(
                  label: 'Save Changes',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.updateProfile(
                        name: nameCtrl.text.trim(),
                        email: emailCtrl.text.trim().isEmpty
                            ? null
                            : emailCtrl.text.trim(),
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
