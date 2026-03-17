import 'package:get/get.dart';
import '../../data/models/order_model.dart';

class OrderController extends GetxController {
  final isLoading = false.obs;
  final orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      orders.value = [
        OrderModel(
          id: 'ORD-12345',
          type: ServiceType.food,
          title: 'Burger King',
          subtitle: '2 Items • Delivered',
          amount: 450.0,
          date: DateTime.now().subtract(const Duration(days: 1)),
          status: OrderStatus.delivered,
        ),
        OrderModel(
          id: 'ORD-67890',
          type: ServiceType.ride,
          title: 'Gulshan 2 to Banani',
          subtitle: 'Toyota Corolla • Completed',
          amount: 120.0,
          date: DateTime.now().subtract(const Duration(hours: 5)),
          status: OrderStatus.delivered,
        ),
        OrderModel(
          id: 'ORD-11223',
          type: ServiceType.grocery,
          title: 'Fresh Mart',
          subtitle: '8 Items • Processing',
          amount: 1250.0,
          date: DateTime.now().subtract(const Duration(minutes: 30)),
          status: OrderStatus.processing,
        ),
        OrderModel(
          id: 'ORD-44556',
          type: ServiceType.pharmacy,
          title: 'Lazz Pharma',
          subtitle: 'Prescription Order • Pending',
          amount: 850.0,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          status: OrderStatus.pending,
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }
}
