import 'package:get/get.dart';
import '../../data/models/ride_model.dart';

enum RideStatus { idle, searching, arriving, ongoing, completed }

class RideController extends GetxController {
  final status = RideStatus.idle.obs;
  final rideTypes = <RideTypeModel>[].obs;
  final selectedRideType = Rxn<RideTypeModel>();
  final selectedDriver = Rxn<DriverModel>();

  final pickupAddress = 'Current Location'.obs;
  final destinationAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRideTypes();
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
      lat: 23.794,
      lng: 90.404,
    );
    status.value = RideStatus.arriving;
  }

  void cancelRide() {
    status.value = RideStatus.idle;
    selectedDriver.value = null;
  }
}
