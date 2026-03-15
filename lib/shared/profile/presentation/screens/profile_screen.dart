import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/controllers/language_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../data/repositories/profile_repository.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();
        final p = controller.profile.value;
        if (p == null)
          return const AppErrorWidget(message: 'Failed to load profile');
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Avatar
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryLight,
                backgroundImage: p.avatar != null
                    ? NetworkImage(p.avatar!)
                    : null,
                child: p.avatar == null
                    ? Text(
                        p.name[0].toUpperCase(),
                        style: AppTextStyles.displayMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 12),
              Text(p.name, style: AppTextStyles.heading1),
              Text(
                p.phone,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              _ProfileMenuItem(
                icon: Icons.edit_outlined,
                label: 'Edit Profile',
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              _ProfileMenuItem(
                icon: Icons.location_on_outlined,
                label: 'Saved Addresses',
                onTap: () => Get.toNamed(AppRoutes.addressBook),
              ),
              _ProfileMenuItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Wallet',
                onTap: () => Get.toNamed(AppRoutes.wallet),
              ),
              _ProfileMenuItem(
                icon: Icons.history,
                label: 'Order History',
                onTap: () => Get.toNamed(AppRoutes.ecommerceOrderHistory),
              ),
              _ProfileMenuItem(
                icon: Icons.language,
                label: Get.find<LanguageController>().isEnglish
                    ? 'বাংলা (Bengali)'
                    : 'English',
                onTap: () => Get.find<LanguageController>().toggleLanguage(),
              ),
              _ProfileMenuItem(
                icon: Icons.notifications_outlined,
                label: 'notifications'.tr,
                onTap: () => Get.toNamed(AppRoutes.notifications),
              ),
              const SizedBox(height: 16),
              _ProfileMenuItem(
                icon: Icons.logout,
                label: 'Logout',
                color: AppColors.error,
                onTap: controller.logout,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.primary),
        title: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color ?? AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: color ?? AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
