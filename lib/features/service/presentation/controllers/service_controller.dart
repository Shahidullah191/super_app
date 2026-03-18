import 'package:get/get.dart';
import '../../data/models/service_model.dart';
import '../../data/repositories/service_repository.dart';
import '../../../../app/routes/app_routes.dart';

class ServiceController extends GetxController {
  final _repo = ServiceRepository();

  final isLoading = false.obs;
  final categories = <ServiceCategoryModel>[].obs;
  final providers = <ServiceProviderModel>[].obs;
  final serviceHistory = <Map<String, dynamic>>[].obs;
  final selectedCategory = Rxn<ServiceCategoryModel>();
  final selectedProvider = Rxn<ServiceProviderModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchServiceHistory();
  }

  void fetchCategories() {
    categories.value = [
      ServiceCategoryModel(
        id: 1,
        name: 'Electrician',
        icon: '⚡',
        description: 'Fan, Light, Wiring repair',
      ),
      ServiceCategoryModel(
        id: 2,
        name: 'Plumber',
        icon: '🚰',
        description: 'Tap, Pipe, Tank repair',
      ),
      ServiceCategoryModel(
        id: 3,
        name: 'AC Repair',
        icon: '❄️',
        description: 'Servicing, Gas refill',
      ),
      ServiceCategoryModel(
        id: 4,
        name: 'Cleaning',
        icon: '🧹',
        description: 'Home, Sofa, Carpet cleaning',
      ),
    ];

    _fetchCategoriesFromApi();
  }

  Future<void> _fetchCategoriesFromApi() async {
    try {
      final res = await _repo.getCategories();
      if (res.isNotEmpty) categories.value = res;
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> fetchProviders(int categoryId) async {
    isLoading.value = true;
    try {
      // ── Demo Logic ─────────────────────────────────────────────────────────
      providers.value = [
        ServiceProviderModel(
          id: 1,
          name: 'Abdur Rahman',
          image:
              'https://images.unsplash.com/photo-1540569014015-19a7be504e3a?q=80&w=1935&auto=format&fit=crop',
          rating: 4.8,
          experience: '5 years',
          startingPrice: 500,
          services: ['Fan Repair', 'Wiring', 'Circuit Breaker'],
        ),
        ServiceProviderModel(
          id: 2,
          name: 'Sujon Mia',
          image:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1974&auto=format&fit=crop',
          rating: 4.5,
          experience: '3 years',
          startingPrice: 400,
          services: ['Light Fitting', 'Switch Repair'],
        ),
      ];

      final res = await _repo.getProviders(categoryId);
      if (res.isNotEmpty) providers.value = res;
    } catch (_) {
      // Silent fail
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchServiceHistory() async {
    try {
      final res = await _repo.getServiceHistory();
      if (res.isNotEmpty) serviceHistory.value = res;
    } catch (_) {
      // Silent fail
    }
  }

  Future<void> bookService(Map<String, dynamic> bookingData) async {
    isLoading.value = true;
    try {
      // ── Demo Logic ─────────────────────────────────────────────────────────
      final newBooking = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'booking_number': 'SERV-${DateTime.now().millisecondsSinceEpoch}',
        'category': selectedCategory.value?.name,
        'provider': selectedProvider.value?.name,
        'date': bookingData['date'],
        'time': bookingData['time'],
        'description': bookingData['description'],
        'price': selectedProvider.value?.startingPrice ?? 0.0,
        'status': 'Pending',
        'created_at': DateTime.now().toIso8601String(),
      };

      serviceHistory.insert(0, newBooking);
      await _repo.bookService(newBooking);

      Get.snackbar('Success', 'Service booking confirmed!');
      Get.offAllNamed(AppRoutes.mainNav);
    } catch (e) {
      Get.snackbar('Error', 'Failed to book service');
    } finally {
      isLoading.value = false;
    }
  }
}
