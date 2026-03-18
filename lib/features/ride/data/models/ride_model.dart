class RideTypeModel {
  final int id;
  final String name;
  final String image;
  final double baseFare;
  final double perKmRate;
  final String capacity;

  RideTypeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.baseFare,
    required this.perKmRate,
    required this.capacity,
  });

  factory RideTypeModel.fromJson(Map<String, dynamic> json) {
    return RideTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      baseFare: (json['base_fare'] as num).toDouble(),
      perKmRate: (json['per_km_rate'] as num).toDouble(),
      capacity: json['capacity'] as String,
    );
  }
}

class DriverModel {
  final int id;
  final String name;
  final String image;
  final String phone;
  final double rating;
  final String vehicleName;
  final String vehicleNumber;
  final double lat;
  final double lng;

  DriverModel({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    required this.rating,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.lat,
    required this.lng,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      phone: json['phone'] as String,
      rating: (json['rating'] as num).toDouble(),
      vehicleName: json['vehicle_name'] as String,
      vehicleNumber: json['vehicle_number'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}
