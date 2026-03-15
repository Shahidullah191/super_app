import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../data/models/address_model.dart';
import '../controllers/address_controller.dart';

class AddAddressScreen extends GetView<AddressController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final addressCtrl = TextEditingController();
    final areaCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final labelOptions = ['Home', 'Work', 'Other'];
    final selectedLabel = 'Home'.obs;

    return Scaffold(
      appBar: AppBar(title: Text('add_address'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label selector
              Obx(
                () => Wrap(
                  spacing: 10,
                  children: labelOptions
                      .map(
                        (l) => ChoiceChip(
                          label: Text(l),
                          selected: selectedLabel.value == l,
                          selectedColor: AppColors.primaryLight,
                          onSelected: (_) => selectedLabel.value = l,
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'address'.tr,
                hint: 'address_hint'.tr,
                controller: addressCtrl,
                prefixIcon: const Icon(Icons.home_outlined, size: 20),
                validator: (v) =>
                    AppValidators.required(v, field: 'address'.tr),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'area'.tr,
                hint: 'area_hint'.tr,
                controller: areaCtrl,
                prefixIcon: const Icon(Icons.map_outlined, size: 20),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'city'.tr,
                hint: 'city_hint'.tr,
                controller: cityCtrl,
                prefixIcon: const Icon(Icons.location_city_outlined, size: 20),
                validator: (v) => AppValidators.required(v, field: 'city'.tr),
              ),
              const SizedBox(height: 32),
              CustomButton(
                label: 'save_address'.tr,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.addAddress(
                      AddressModel(
                        id: 0,
                        label: selectedLabel.value,
                        address: addressCtrl.text.trim(),
                        area: areaCtrl.text.trim().isEmpty
                            ? null
                            : areaCtrl.text.trim(),
                        city: cityCtrl.text.trim(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
