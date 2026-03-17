import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('help_center'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 32),
            Text('Frequently Asked Questions', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildFAQItem(
              'How to track my order?',
              'You can track your order from the "Order History" section in your profile.',
            ),
            _buildFAQItem(
              'What are the payment methods?',
              'We support Credit/Debit cards, Mobile Banking (bKash, Nagad), and Cash on Delivery.',
            ),
            _buildFAQItem(
              'How to cancel an order?',
              'Orders can be cancelled within 5 minutes of placement from the tracking screen.',
            ),
            _buildFAQItem(
              'Is there a delivery fee?',
              'Delivery fees vary based on distance and service type. You can see the fee at checkout.',
            ),
            const SizedBox(height: 32),
            Text('Contact Support', style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            _buildContactCard(
              Icons.chat_bubble_outline,
              'Live Chat',
              'Chat with our support team',
              Colors.blue,
            ),
            _buildContactCard(
              Icons.email_outlined,
              'Email Support',
              'support@superapp.com',
              Colors.orange,
            ),
            _buildContactCard(
              Icons.phone_outlined,
              'Call Us',
              '+880 1234 567890',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search for help...',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: AppColors.textSecondary),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {},
      ),
    );
  }
}
