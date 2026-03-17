import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: ListView(
        children: [
          _buildSection('App Settings', [
            _buildTile(
              Icons.language_outlined,
              'Language',
              'English',
              onTap: () => _showLanguageDialog(context),
            ),
            _buildTile(
              Icons.dark_mode_outlined,
              'Dark Mode',
              'Off',
              trailing: Switch(
                value: false,
                onChanged: (v) {},
                activeColor: AppColors.primary,
              ),
            ),
            _buildTile(
              Icons.notifications_none_outlined,
              'Push Notifications',
              null,
              trailing: Switch(
                value: true,
                onChanged: (v) {},
                activeColor: AppColors.primary,
              ),
            ),
          ]),
          _buildSection('Account & Security', [
            _buildTile(Icons.lock_outline, 'Change Password', null),
            _buildTile(
              Icons.security_outlined,
              'Two-Factor Authentication',
              'Off',
            ),
            _buildTile(
              Icons.delete_outline,
              'Delete Account',
              null,
              isDestructive: true,
            ),
          ]),
          _buildSection('About', [
            _buildTile(Icons.info_outline, 'Privacy Policy', null),
            _buildTile(Icons.description_outlined, 'Terms of Service', null),
            _buildTile(Icons.verified_outlined, 'App Version', '1.0.0'),
          ]),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Logout'),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    String? subtitle, {
    Widget? trailing,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.error : AppColors.textPrimary,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isDestructive ? AppColors.error : AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: AppTextStyles.bodySmall)
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              leading: Radio<String>(
                value: 'en',
                groupValue: Get.locale?.languageCode,
                onChanged: (v) {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
            ),
            ListTile(
              title: const Text('বাংলা'),
              leading: Radio<String>(
                value: 'bn',
                groupValue: Get.locale?.languageCode,
                onChanged: (v) {
                  Get.updateLocale(const Locale('bn', 'BD'));
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
