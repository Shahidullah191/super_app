enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum ServiceType { food, grocery, pharmacy, ride, courier, service }

class OrderModel {
  final String id;
  final ServiceType type;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.status,
  });
}
