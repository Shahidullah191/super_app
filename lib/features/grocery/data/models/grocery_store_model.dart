class GroceryStoreModel {
  final int id;
  final String name;
  final String image;
  final String address;
  final double rating;
  final String deliveryTime;

  GroceryStoreModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.rating,
    required this.deliveryTime,
  });

  factory GroceryStoreModel.fromJson(Map<String, dynamic> json) {
    return GroceryStoreModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      address: json['address'] as String,
      rating: (json['rating'] as num).toDouble(),
      deliveryTime: json['delivery_time'] as String,
    );
  }
}
