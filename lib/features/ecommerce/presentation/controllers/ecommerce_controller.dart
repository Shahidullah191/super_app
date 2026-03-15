import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/ecommerce_repository.dart';

class EcommerceController extends GetxController {
  final _repo = EcommerceRepository();

  final categories = <CategoryModel>[].obs;
  final products = <ProductModel>[].obs;
  final isLoading = false.obs;
  final isCategoriesLoading = false.obs;

  final selectedCategoryId = Rxn<int>();
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      categories.value = await _repo.getCategories();
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) products.clear();
    isLoading.value = true;
    try {
      products.value = await _repo.getProducts(
        categoryId: selectedCategoryId.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
      );
    } on AppException catch (e) {
      Get.snackbar('error'.tr, e.message);
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(int? id) {
    selectedCategoryId.value = id;
    fetchProducts(refresh: true);
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    fetchProducts(refresh: true);
  }
}
