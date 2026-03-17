class MedicineModel {
  final int id;
  final String name;
  final String genericName;
  final String manufacturer;
  final double price;
  final String image;
  final String type; // Tablet, Syrup, etc.
  final String strength; // 500mg, 10ml, etc.

  MedicineModel({
    required this.id,
    required this.name,
    required this.genericName,
    required this.manufacturer,
    required this.price,
    required this.image,
    required this.type,
    required this.strength,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] as int,
      name: json['name'] as String,
      genericName: json['generic_name'] as String,
      manufacturer: json['manufacturer'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      type: json['type'] as String,
      strength: json['strength'] as String,
    );
  }
}
