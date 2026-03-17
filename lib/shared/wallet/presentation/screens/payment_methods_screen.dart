import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('payment_methods'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionTitle('Saved Cards'),
          _buildPaymentTile(
            Icons.credit_card,
            'Visa •••• 4242',
            'Expires 12/25',
            Colors.blue,
          ),
          _buildPaymentTile(
            Icons.credit_card,
            'Mastercard •••• 8888',
            'Expires 09/24',
            Colors.orange,
          ),
          _buildAddButton('Add New Card'),
          const SizedBox(height: 32),
          _buildSectionTitle('Mobile Wallets'),
          _buildPaymentTile(
            Icons.account_balance_wallet_outlined,
            'bKash',
            '017 •••• 5678',
            Colors.pink,
          ),
          _buildPaymentTile(
            Icons.account_balance_wallet_outlined,
            'Nagad',
            '019 •••• 1234',
            Colors.red,
          ),
          _buildAddButton('Link New Wallet'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPaymentTile(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildAddButton(String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add, size: 20),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
