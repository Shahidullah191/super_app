import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> demoNotifications = [
      {
        'title': 'Order Delivered',
        'body':
            'Your order from Burger King has been delivered. Enjoy your meal!',
        'time': '2 mins ago',
        'icon': '🍔',
      },
      {
        'title': 'Ride Completed',
        'body': 'Your ride with Arif Ahmed is completed. Rate your experience.',
        'time': '1 hour ago',
        'icon': '🚗',
      },
      {
        'title': 'Wallet Credited',
        'body': '৳500 has been added to your wallet via bKash.',
        'time': '3 hours ago',
        'icon': '💰',
      },
      {
        'title': 'New Offer!',
        'body': 'Get 20% off on your next grocery order. Use code: SUPER20',
        'time': '1 day ago',
        'icon': '🎉',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('notifications'.tr),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'mark_all_read'.tr,
              style: const TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: demoNotifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off_outlined,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text('no_notifications'.tr, style: AppTextStyles.heading3),
                  const SizedBox(height: 8),
                  Text(
                    'no_notifications_sub'.tr,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: demoNotifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notification = demoNotifications[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          notification['icon']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification['title']!,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notification['body']!,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notification['time']!,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
