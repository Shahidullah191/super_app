import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../controllers/order_controller.dart';
import '../../data/models/order_model.dart';

class OrderHistoryScreen extends GetView<OrderController> {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('order_history'.tr)),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingWidget();
        if (controller.orders.isEmpty) {
          return EmptyWidget(
            message: 'no_orders'.tr,
            icon: Icons.history_outlined,
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.orders.length,
          itemBuilder: (_, i) => _OrderCard(order: controller.orders[i]),
        );
      }),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _getTypeColor(order.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTypeIcon(order.type),
                    color: _getTypeColor(order.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.title, style: AppTextStyles.heading3),
                      Text(
                        DateFormat('dd MMM yyyy, hh:mm a').format(order.date),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: order.status),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '৳${order.amount}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(ServiceType type) {
    switch (type) {
      case ServiceType.food:
        return Icons.restaurant_outlined;
      case ServiceType.grocery:
        return Icons.shopping_basket_outlined;
      case ServiceType.pharmacy:
        return Icons.medical_services_outlined;
      case ServiceType.ride:
        return Icons.directions_car_outlined;
      case ServiceType.courier:
        return Icons.local_shipping_outlined;
      case ServiceType.service:
        return Icons.build_outlined;
    }
  }

  Color _getTypeColor(ServiceType type) {
    switch (type) {
      case ServiceType.food:
        return Colors.orange;
      case ServiceType.grocery:
        return Colors.green;
      case ServiceType.pharmacy:
        return Colors.red;
      case ServiceType.ride:
        return Colors.blue;
      case ServiceType.courier:
        return Colors.purple;
      case ServiceType.service:
        return Colors.teal;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.name.capitalizeFirst!,
        style: AppTextStyles.tag.copyWith(
          color: _getStatusColor(status),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}
