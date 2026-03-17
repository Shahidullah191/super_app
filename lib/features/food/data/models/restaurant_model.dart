class MenuItemModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      category: json['category'] as String,
    );
  }
}

class RestaurantModel {
  final int id;
  final String name;
  final String image;
  final String address;
  final double rating;
  final String deliveryTime;
  final List<String> cuisines;
  final List<MenuItemModel> menu;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.rating,
    required this.deliveryTime,
    required this.cuisines,
    this.menu = const [],
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      address: json['address'] as String,
      rating: (json['rating'] as num).toDouble(),
      deliveryTime: json['delivery_time'] as String,
      cuisines: (json['cuisines'] as List).map((e) => e as String).toList(),
      menu: (json['menu'] as List? ?? [])
          .map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
