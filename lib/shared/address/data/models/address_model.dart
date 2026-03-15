// ── Address Model ─────────────────────────────────────────────────────────────
class AddressModel {
  final int id;
  final String label; // Home, Work, Other
  final String address;
  final String? area;
  final String city;
  final double? lat;
  final double? lng;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.label,
    required this.address,
    this.area,
    required this.city,
    this.lat,
    this.lng,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json['id'] as int,
    label: json['label'] as String,
    address: json['address'] as String,
    area: json['area'] as String?,
    city: json['city'] as String,
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
    isDefault: json['is_default'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'label': label,
    'address': address,
    'area': area,
    'city': city,
    'lat': lat,
    'lng': lng,
    'is_default': isDefault,
  };
}
