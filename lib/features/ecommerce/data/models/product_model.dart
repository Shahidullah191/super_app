class CategoryModel {
  final int id;
  final String name;
  final String? image;
  final String? slug;

  CategoryModel({required this.id, required this.name, this.image, this.slug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String?,
      slug: json['slug'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'slug': slug};
  }
}

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String image;
  final List<String> gallery;
  final int categoryId;
  final int stock;
  final double rating;
  final int reviewCount;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.image,
    this.gallery = const [],
    required this.categoryId,
    this.stock = 0,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  double get currentPrice => hasDiscount ? discountPrice! : price;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      discountPrice: json['discount_price'] != null
          ? (json['discount_price'] as num).toDouble()
          : null,
      image: json['image'] as String,
      gallery: (json['gallery'] as List? ?? [])
          .map((e) => e as String)
          .toList(),
      categoryId: json['category_id'] as int,
      stock: json['stock'] as int? ?? 0,
      rating: (json['rating'] as num? ?? 0.0).toDouble(),
      reviewCount: json['review_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount_price': discountPrice,
      'image': image,
      'gallery': gallery,
      'category_id': categoryId,
      'stock': stock,
      'rating': rating,
      'review_count': reviewCount,
    };
  }
}
