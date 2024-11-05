// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../data/models/berita.dart';
import '../../../data/api_service.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage

class HomeController extends GetxController {
  var beritas = <Berita>[].obs;
  var isLoading = true.obs;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchBeritas();
    super.onInit();
  }

  void fetchBeritas() async {
    try {
      isLoading(true);
      var beritaList = await apiService.fetchBeritas();
      if (beritaList.isNotEmpty) {
        beritas.assignAll(beritaList);
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    try {
      // Hapus token dari GetStorage
      final storage = GetStorage();
      await storage.remove('auth_token'); // Menghapus token otentikasi

      // Redirect ke halaman login
      Get.offAllNamed('/login'); // Pastikan Anda memiliki route '/login'
    } catch (e) {
      print("Error during logout: $e");
    }
  }
}
