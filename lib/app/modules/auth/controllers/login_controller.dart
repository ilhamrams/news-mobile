import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api_service.dart';
import '../../../data/models/login_response.dart';
import '../../../routes/app_routes.dart'; // Pastikan import ini ada untuk akses AppRoutes

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginResponse = LoginResponse(success: false, message: '').obs;

  final ApiService apiService = ApiService();
  final GetStorage storage = GetStorage();

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final response = await apiService.login(email, password);

    if (response.success) {
      // Login berhasil, simpan token jika diperlukan, lalu arahkan ke Home
      loginResponse.value = response;
      storage.write('auth_token', response.accessToken); // Simpan token
      Get.snackbar('Login Successful', response.message);
      Get.offAllNamed(AppRoutes.HOME); // Arahkan ke Home
    } else {
      // Login gagal, tampilkan pesan error
      Get.snackbar('Login Failed', response.message);
    }

    isLoading.value = false;
  }
}
