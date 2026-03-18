class GroceryProductModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final String unit;
  final String category;

  GroceryProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.unit,
    required this.category,
  });

  factory GroceryProductModel.fromJson(Map<String, dynamic> json) {
    return GroceryProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] as String,
      category: json['category'] as String,
    );
  }
}
