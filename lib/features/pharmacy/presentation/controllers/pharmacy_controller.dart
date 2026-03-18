import 'package:get/get.dart';
import '../../data/models/medicine_model.dart';
import '../../data/repositories/pharmacy_repository.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/network/api_client.dart';

class PharmacyController extends GetxController {
  final _repo = PharmacyRepository();

  final isLoading = false.obs;
  final medicines = <MedicineModel>[].obs;
  final cartItems = <MedicineModel, int>{}.obs;
  final pharmacyOrders = <Map<String, dynamic>>[].obs;
  final prescriptionImage = Rxn<String>();

  double get subtotal => cartItems.entries
      .map((e) => e.key.price * e.value)
      .fold(0, (a, b) => a + b);

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
    fetchPharmacyOrderHistory();
  }

  Future<void> fetchMedicines() async {
    Future.microtask(() => isLoading.value = true);
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      medicines.value = [
        MedicineModel(
          id: 1,
          name: 'Napa Extend',
          genericName: 'Paracetamol',
          manufacturer: 'Beximco Pharmaceuticals',
          price: 15.0,
          image:
              'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop',
          type: 'Tablet',
          strength: '665mg',
        ),
        MedicineModel(
          id: 2,
          name: 'Seclo 20',
          genericName: 'Omeprazole',
          manufacturer: 'Square Pharmaceuticals',
          price: 5.0,
          image:
              'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?q=80&w=2070&auto=format&fit=crop',
          type: 'Capsule',
          strength: '20mg',
        ),
        MedicineModel(
          id: 3,
          name: 'Fexo 120',
          genericName: 'Fexofenadine',
          manufacturer: 'Incepta Pharmaceuticals',
          price: 8.0,
          image:
              'https://images.unsplash.com/photo-1550572017-ed200f545dec?q=80&w=2070&auto=format&fit=crop',
          type: 'Tablet',
          strength: '120mg',
        ),
      ];

      final res = await _repo.getMedicines();
      if (res.isNotEmpty) medicines.value = res;
    } on AppException catch (_) {
      // Silent fail - use demo data
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPharmacyOrderHistory() async {
    try {
      final res = await _repo.getPharmacyOrderHistory();
      if (res.isNotEmpty) pharmacyOrders.value = res;
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> placeOrder(Map<String, dynamic> orderData) async {
    isLoading.value = true;
    try {
      // ── Demo Logic ─────────────────────────────────────────────────────────
      final newOrder = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'order_number': 'PHAR-${DateTime.now().millisecondsSinceEpoch}',
        'items': cartItems.entries
            .map(
              (e) => {
                'name': e.key.name,
                'quantity': e.value,
                'price': e.key.price,
              },
            )
            .toList(),
        'subtotal': subtotal,
        'delivery_fee': 40,
        'total': subtotal + 40,
        'status': 'Pending',
        'date': DateTime.now().toIso8601String(),
        'address': orderData['address'],
        'payment_method': orderData['payment_method'],
        'prescription': prescriptionImage.value,
      };

      pharmacyOrders.insert(0, newOrder);
      await _repo.placePharmacyOrder(newOrder);

      clearCart();
      Get.offNamed(
        AppRoutes.pharmacyOrderConfirmation,
        arguments: {
          'title': 'Order Placed Successfully!',
          'subTitle': 'Your medicines will be delivered after verification.',
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to place order');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(MedicineModel medicine) {
    if (cartItems.containsKey(medicine)) {
      cartItems[medicine] = cartItems[medicine]! + 1;
    } else {
      cartItems[medicine] = 1;
    }
  }

  void removeFromCart(MedicineModel medicine) {
    if (cartItems.containsKey(medicine)) {
      if (cartItems[medicine] == 1) {
        cartItems.remove(medicine);
      } else {
        cartItems[medicine] = cartItems[medicine]! - 1;
      }
    }
  }

  void uploadPrescription(String path) {
    prescriptionImage.value = path;
  }

  void clearCart() {
    cartItems.clear();
    prescriptionImage.value = null;
  }
}
