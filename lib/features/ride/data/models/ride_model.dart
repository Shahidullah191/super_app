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
}
