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
  final wishlist = <ProductModel>[].obs;
  final reviews = <ReviewModel>[].obs;

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
      // ── Demo Data ──────────────────────────────────────────────────────────
      categories.value = [
        CategoryModel(id: 1, name: 'Electronics', slug: 'electronics'),
        CategoryModel(id: 2, name: 'Fashion', slug: 'fashion'),
        CategoryModel(id: 3, name: 'Home & Living', slug: 'home-living'),
        CategoryModel(id: 4, name: 'Beauty', slug: 'beauty'),
        CategoryModel(id: 5, name: 'Sports', slug: 'sports'),
      ];

      final res = await _repo.getCategories();
      if (res.isNotEmpty) categories.value = res;
    } on AppException catch (_) {
      // Fail silently – show demo data
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) {
      products.clear();
    }
    Future.microtask(() => isLoading.value = true);
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      final demoProducts = [
        ProductModel(
          id: 1,
          name: 'Wireless Headphones',
          description:
              'High-quality wireless headphones with noise cancellation.',
          price: 5500,
          discountPrice: 4800,
          image:
              'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=2070&auto=format&fit=crop',
          categoryId: 1,
          rating: 4.5,
          reviewCount: 120,
        ),
        ProductModel(
          id: 2,
          name: 'Smart Watch',
          description: 'Feature-rich smart watch with heart rate monitoring.',
          price: 3200,
          image:
              'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1999&auto=format&fit=crop',
          categoryId: 1,
          rating: 4.2,
          reviewCount: 85,
        ),
        ProductModel(
          id: 3,
          name: 'Cotton T-Shirt',
          description: 'Comfortable 100% cotton t-shirt for daily wear.',
          price: 850,
          discountPrice: 650,
          image:
              'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=2080&auto=format&fit=crop',
          categoryId: 2,
          rating: 4.8,
          reviewCount: 210,
        ),
        ProductModel(
          id: 4,
          name: 'Leather Wallet',
          description: 'Premium leather wallet with multiple card slots.',
          price: 1200,
          image:
              'https://images.unsplash.com/photo-1627123424574-724758594e93?q=80&w=1974&auto=format&fit=crop',
          categoryId: 2,
          rating: 4.6,
          reviewCount: 45,
        ),
      ];

      products.value = demoProducts.where((p) {
        if (selectedCategoryId.value != null &&
            p.categoryId != selectedCategoryId.value) {
          return false;
        }
        if (searchQuery.value.isNotEmpty &&
            !p.name.toLowerCase().contains(searchQuery.value.toLowerCase())) {
          return false;
        }
        return true;
      }).toList();

      final res = await _repo.getProducts(
        categoryId: selectedCategoryId.value,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
      );
      if (res.isNotEmpty) {
        products.value = res;
      }
    } on AppException catch (_) {
      // Fail silently – show demo data
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

  Future<ProductModel?> getProductDetails(int id) async {
    Future.microtask(() => isLoading.value = true);
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      final demoProducts = [
        ProductModel(
          id: 1,
          name: 'Wireless Headphones',
          description:
              'High-quality wireless headphones with noise cancellation. Experience crystal clear sound and deep bass. Perfect for music lovers and professionals alike. Features include 40-hour battery life, fast charging, and comfortable over-ear design.',
          price: 5500,
          discountPrice: 4800,
          image:
              'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=2070&auto=format&fit=crop',
          gallery: [
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=2070&auto=format&fit=crop',
            'https://images.unsplash.com/photo-1484704849700-f032a568e944?q=80&w=2070&auto=format&fit=crop',
            'https://images.unsplash.com/photo-1524678606370-a47ad25cb82a?q=80&w=2069&auto=format&fit=crop',
          ],
          categoryId: 1,
          rating: 4.5,
          reviewCount: 120,
          stock: 15,
        ),
        ProductModel(
          id: 2,
          name: 'Smart Watch',
          description:
              'Feature-rich smart watch with heart rate monitoring, GPS, and water resistance. Stay connected and track your fitness goals with ease. Compatible with both iOS and Android devices.',
          price: 3200,
          image:
              'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1999&auto=format&fit=crop',
          categoryId: 1,
          rating: 4.2,
          reviewCount: 85,
          stock: 25,
        ),
      ];

      final demoProduct = demoProducts.firstWhereOrNull((p) => p.id == id);

      try {
        final res = await _repo.getProductDetails(id);
        return res;
      } catch (_) {
        return demoProduct;
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Wishlist ───────────────────────────────────────────────────────────────
  void toggleWishlist(ProductModel product) {
    if (isInWishlist(product.id)) {
      wishlist.removeWhere((p) => p.id == product.id);
      Get.snackbar('Wishlist', 'Removed from wishlist');
    } else {
      wishlist.add(product);
      Get.snackbar('Wishlist', 'Added to wishlist');
    }
  }

  bool isInWishlist(int productId) {
    return wishlist.any((p) => p.id == productId);
  }

  // ── Reviews ────────────────────────────────────────────────────────────────
  void fetchReviews(int productId) {
    reviews.value = [
      ReviewModel(
        id: 1,
        userName: 'John Doe',
        rating: 5,
        comment: 'Excellent sound quality and very comfortable!',
        date: '2 days ago',
      ),
      ReviewModel(
        id: 2,
        userName: 'Jane Smith',
        rating: 4,
        comment:
            'Good battery life, but the noise cancellation could be better.',
        date: '1 week ago',
      ),
    ];
  }
}

class ReviewModel {
  final int id;
  final String userName;
  final double rating;
  final String comment;
  final String date;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}
