enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum ServiceType { food, grocery, pharmacy, ride, courier, service }

class OrderItemModel {
  final String name;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class OrderModel {
  final String id;
  final ServiceType type;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final OrderStatus status;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.status,
    this.items = const [],
  });

  double get totalAmount => amount;
}
