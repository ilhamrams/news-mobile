// main.dart
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/home/controllers/navigation_controller.dart ';

void main() async {
  await GetStorage.init(); // Inisialisasi GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigationController navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyApp',
      initialRoute: AppPages.INITIAL, // Rute awal aplikasi
      getPages: AppPages.routes, // Daftar semua rute
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema utama aplikasi
      ),
    );
  }
}
