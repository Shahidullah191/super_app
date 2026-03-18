import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/ride_model.dart';
import '../../data/repositories/ride_repository.dart';
import '../../../../app/routes/app_routes.dart';

enum RideStatus { idle, searching, arriving, ongoing, completed }

class RideController extends GetxController {
  final _repo = RideRepository();

  final status = RideStatus.idle.obs;
  final rideTypes = <RideTypeModel>[].obs;
  final rideHistory = <Map<String, dynamic>>[].obs;
  final selectedRideType = Rxn<RideTypeModel>();
  final selectedDriver = Rxn<DriverModel>();
  final driverPosition = Rxn<LatLng>();
  Timer? _movementTimer;

  final pickupAddress = 'Current Location'.obs;
  final destinationAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRideTypes();
    fetchRideHistory();
  }

  void _loadRideTypes() {
    rideTypes.value = [
      RideTypeModel(
        id: 1,
        name: 'Bike',
        image: 'https://cdn-icons-png.flaticon.com/512/2972/2972185.png',
        baseFare: 30,
        perKmRate: 12,
        capacity: '1 Person',
      ),
      RideTypeModel(
        id: 2,
        name: 'Car (Economy)',
        image: 'https://cdn-icons-png.flaticon.com/512/3202/3202926.png',
        baseFare: 50,
        perKmRate: 20,
        capacity: '4 Persons',
      ),
      RideTypeModel(
        id: 3,
        name: 'Car (Premium)',
        image: 'https://cdn-icons-png.flaticon.com/512/741/741407.png',
        baseFare: 100,
        perKmRate: 35,
        capacity: '4 Persons',
      ),
    ];
    selectedRideType.value = rideTypes.first;

    _fetchRideTypesFromApi();
  }

  Future<void> _fetchRideTypesFromApi() async {
    try {
      final res = await _repo.getRideTypes();
      if (res.isNotEmpty) {
        rideTypes.value = res;
        selectedRideType.value = rideTypes.first;
      }
    } catch (_) {
      // Silent fail - use demo data
    }
  }

  Future<void> fetchRideHistory() async {
    try {
      final res = await _repo.getRideHistory();
      if (res.isNotEmpty) rideHistory.value = res;
    } catch (_) {
      // Silent fail
    }
  }

  void startSearching() async {
    status.value = RideStatus.searching;
    await Future.delayed(const Duration(seconds: 3));
    _assignDriver();
  }

  void _assignDriver() {
    selectedDriver.value = DriverModel(
      id: 1,
      name: 'Rahim Uddin',
      image:
          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop',
      phone: '01712345678',
      rating: 4.9,
      vehicleName: 'Toyota Corolla',
      vehicleNumber: 'Dhaka Metro-Ga 12-3456',
      lat: 23.7950,
      lng: 90.4140,
    );
    driverPosition.value = LatLng(23.7950, 90.4140);
    status.value = RideStatus.arriving;
    _startMovementSimulation();
  }

  void _startMovementSimulation() {
    _movementTimer?.cancel();
    _movementTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (driverPosition.value == null) return;

      // Simulate movement towards pickup (23.7940, 90.4125)
      double lat = driverPosition.value!.latitude;
      double lng = driverPosition.value!.longitude;

      if (lat > 23.7940) lat -= 0.0001;
      if (lng > 90.4125) lng -= 0.0001;

      driverPosition.value = LatLng(lat, lng);

      if ((lat - 23.7940).abs() < 0.0001 && (lng - 90.4125).abs() < 0.0001) {
        timer.cancel();
        status.value = RideStatus.ongoing;
      }
    });
  }

  void cancelRide() {
    _movementTimer?.cancel();
    status.value = RideStatus.idle;
    selectedDriver.value = null;
    driverPosition.value = null;
  }

  Future<void> completeRide() async {
    _movementTimer?.cancel();
    status.value = RideStatus.completed;

    // ── Demo Logic ─────────────────────────────────────────────────────────
    final newRide = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'ride_number': 'RIDE-${DateTime.now().millisecondsSinceEpoch}',
      'type': selectedRideType.value?.name,
      'driver': selectedDriver.value?.name,
      'fare': 450.0,
      'status': 'Completed',
      'date': DateTime.now().toIso8601String(),
      'pickup': pickupAddress.value,
      'destination': destinationAddress.value,
    };

    rideHistory.insert(0, newRide);
    await _repo.bookRide(
      newRide,
    ); // Assuming booking is used for completion in demo

    Get.offNamed(AppRoutes.rideCompleted);
  }

  @override
  void onClose() {
    _movementTimer?.cancel();
    super.onClose();
  }
}
