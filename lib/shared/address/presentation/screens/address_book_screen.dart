import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../data/models/address_model.dart';
import '../controllers/address_controller.dart';

class AddressBookScreen extends GetView<AddressController> {
  const AddressBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('address_book'.tr)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.addAddress),
        icon: const Icon(Icons.add),
        label: Text('add_address'.tr),
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();
        if (controller.addresses.isEmpty) {
          return EmptyWidget(
            message: 'no_addresses'.tr,
            subMessage: 'no_addresses_sub'.tr,
            icon: Icons.location_off_outlined,
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.addresses.length,
          itemBuilder: (_, i) => _AddressTile(address: controller.addresses[i]),
        );
      }),
    );
  }
}

class _AddressTile extends GetView<AddressController> {
  final AddressModel address;
  const _AddressTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            address.label == 'Home' ? Icons.home_outlined : Icons.work_outline,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(address.label, style: AppTextStyles.heading3),
        subtitle: Text(address.address, style: AppTextStyles.bodySmall),
        trailing: address.isDefault
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'default_label'.tr,
                  style: AppTextStyles.tag.copyWith(color: AppColors.primary),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => controller.deleteAddress(address.id),
              ),
      ),
    );
  }
}
