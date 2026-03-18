class ParcelTypeModel {
  final int id;
  final String name;
  final String icon;
  final String description;

  ParcelTypeModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });

  factory ParcelTypeModel.fromJson(Map<String, dynamic> json) {
    return ParcelTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String? ?? '📦',
      description: json['description'] as String? ?? '',
    );
  }
}
