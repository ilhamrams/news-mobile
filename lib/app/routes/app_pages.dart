// app_pages.dart
// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/profile/views/addberita_view.dart';
import '../modules/profile/bindings/addberita_binding.dart'; // Sesuaikan path untuk login view
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.LOGIN;

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      // binding: LoginBinding(), // Tambahkan binding jika diperlukan
    ),
    GetPage(
      name: AppRoutes.INPUT,
      page: () => BeritaForm(), // Tambahkan halaman Profile
      binding:
          AddberitaBinding(), // Pastikan ProfileBinding sudah disiapkan jika dibutuhkan
    ),
  ];
}
