class ServiceCategoryModel {
  final int id;
  final String name;
  final String icon;
  final String description;

  ServiceCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String? ?? '🛠️',
      description: json['description'] as String? ?? '',
    );
  }
}

class ServiceProviderModel {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String experience;
  final double startingPrice;
  final List<String> services;

  ServiceProviderModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.experience,
    required this.startingPrice,
    required this.services,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      experience: json['experience'] as String? ?? '',
      startingPrice: (json['starting_price'] as num).toDouble(),
      services: (json['services'] as List? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }
}
