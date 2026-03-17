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
}
