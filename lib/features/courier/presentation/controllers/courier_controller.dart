import 'package:get/get.dart';
import '../../data/models/parcel_model.dart';

class CourierController extends GetxController {
  final parcelTypes = <ParcelTypeModel>[].obs;
  final selectedParcelType = Rxn<ParcelTypeModel>();

  @override
  void onInit() {
    super.onInit();
    _loadParcelTypes();
  }

  void _loadParcelTypes() {
    parcelTypes.value = [
      ParcelTypeModel(
        id: 1,
        name: 'Document',
        icon: '📄',
        description: 'Letters, documents, and small papers.',
      ),
      ParcelTypeModel(
        id: 2,
        name: 'Small Box',
        icon: '📦',
        description: 'Up to 2kg, fits in a small bag.',
      ),
      ParcelTypeModel(
        id: 3,
        name: 'Medium Box',
        icon: '📦',
        description: 'Up to 5kg, requires a larger bag.',
      ),
      ParcelTypeModel(
        id: 4,
        name: 'Large Box',
        icon: '📦',
        description: 'Up to 10kg, may require a car.',
      ),
    ];
    selectedParcelType.value = parcelTypes.first;
  }
}
