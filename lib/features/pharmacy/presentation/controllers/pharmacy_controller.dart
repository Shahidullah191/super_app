import 'package:get/get.dart';
import '../../data/models/medicine_model.dart';

class PharmacyController extends GetxController {
  final isLoading = false.obs;
  final medicines = <MedicineModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    isLoading.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      medicines.value = [
        MedicineModel(
          id: 1,
          name: 'Napa Extend',
          genericName: 'Paracetamol',
          manufacturer: 'Beximco Pharmaceuticals',
          price: 15.0,
          image:
              'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop',
          type: 'Tablet',
          strength: '665mg',
        ),
        MedicineModel(
          id: 2,
          name: 'Seclo 20',
          genericName: 'Omeprazole',
          manufacturer: 'Square Pharmaceuticals',
          price: 5.0,
          image:
              'https://images.unsplash.com/photo-1471864190281-a93a3070b6de?q=80&w=2070&auto=format&fit=crop',
          type: 'Capsule',
          strength: '20mg',
        ),
        MedicineModel(
          id: 3,
          name: 'Fexo 120',
          genericName: 'Fexofenadine',
          manufacturer: 'Incepta Pharmaceuticals',
          price: 8.0,
          image:
              'https://images.unsplash.com/photo-1550572017-ed200f545dec?q=80&w=2070&auto=format&fit=crop',
          type: 'Tablet',
          strength: '120mg',
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }
}
