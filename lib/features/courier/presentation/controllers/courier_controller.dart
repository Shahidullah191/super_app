import 'package:get/get.dart';
import '../../data/models/parcel_model.dart';
import '../../data/repositories/courier_repository.dart';
import '../../../../app/routes/app_routes.dart';

class CourierController extends GetxController {
  final _repo = CourierRepository();

  final isLoading = false.obs;
  final parcelTypes = <ParcelTypeModel>[].obs;
  final courierHistory = <Map<String, dynamic>>[].obs;
  final selectedParcelType = Rxn<ParcelTypeModel>();

  @override
  void onInit() {
    super.onInit();
    _loadParcelTypes();
    fetchCourierHistory();
  }

  void _loadParcelTypes() {
    parcelTypes.value = [
      ParcelTypeModel(
        id: 1,
        name: 'Document',
        icon: '📄',
        description: 'Letters, documents, and small papers.',
      ),
      ParcelTypeModel(
        id: 2,
        name: 'Small Box',
        icon: '📦',
        description: 'Up to 2kg, fits in a small bag.',
      ),
      ParcelTypeModel(
        id: 3,
        name: 'Medium Box',
        icon: '📦',
        description: 'Up to 5kg, requires a larger bag.',
      ),
      ParcelTypeModel(
        id: 4,
        name: 'Large Box',
        icon: '📦',
        description: 'Up to 10kg, may require a car.',
      ),
    ];
    selectedParcelType.value = parcelTypes.first;

    _fetchParcelTypesFromApi();
  }

  Future<void> _fetchParcelTypesFromApi() async {
    try {
      final res = await _repo.getParcelTypes();
      if (res.isNotEmpty) {
        parcelTypes.value = res;
        selectedParcelType.value = parcelTypes.first;
      }
    } catch (_) {
      // Silent fail - use demo data
    }
  }

  Future<void> fetchCourierHistory() async {
    try {
      final res = await _repo.getCourierHistory();
      if (res.isNotEmpty) courierHistory.value = res;
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> bookCourier(Map<String, dynamic> courierData) async {
    isLoading.value = true;
    try {
      // ── Demo Logic ─────────────────────────────────────────────────────────
      final newBooking = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'booking_number': 'COUR-${DateTime.now().millisecondsSinceEpoch}',
        'type': selectedParcelType.value?.name,
        'sender': courierData['sender_name'],
        'receiver': courierData['receiver_name'],
        'price': 120.0,
        'status': 'Pending',
        'date': DateTime.now().toIso8601String(),
        'pickup': courierData['pickup_address'],
        'delivery': courierData['delivery_address'],
      };

      courierHistory.insert(0, newBooking);
      await _repo.bookCourier(newBooking);

      Get.offNamed(AppRoutes.courierTracking.replaceAll(':id', '123'));
    } catch (e) {
      Get.snackbar('Error', 'Failed to book courier');
    } finally {
      isLoading.value = false;
    }
  }
}
