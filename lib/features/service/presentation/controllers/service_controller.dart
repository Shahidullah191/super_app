import 'package:get/get.dart';
import '../../data/models/service_model.dart';

class ServiceController extends GetxController {
  final isLoading = false.obs;
  final categories = <ServiceCategoryModel>[].obs;
  final providers = <ServiceProviderModel>[].obs;
  final selectedCategory = Rxn<ServiceCategoryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
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
  }

  void fetchProviders(int categoryId) {
    Future.microtask(() => isLoading.value = true);
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
    isLoading.value = false;
  }
}
