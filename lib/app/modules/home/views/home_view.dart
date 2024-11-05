// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart'; // Pastikan path-nya sesuai

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Tambahkan RefreshIndicator di sini
          return RefreshIndicator(
            onRefresh:
                controller.refreshBeritas, // Fungsi refresh di controller
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Tampilkan 2 kolom
                childAspectRatio: 0.7, // Sesuaikan rasio lebar dan tinggi
              ),
              itemCount: controller.beritas.length,
              itemBuilder: (context, index) {
                final berita = controller.beritas[index];

                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar
                      Expanded(
                        child: Image.network(
                          berita.gambar,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.broken_image, size: 40),
                                Text('Gambar tidak tersedia'),
                              ],
                            );
                          },
                        ),
                      ),
                      // Judul
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          berita.judul,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Subtitle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          berita.artikel,
                          style: TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Index halaman aktif (0 untuk Home)
        onTap: (index) {
          if (index == 0) {
            // Jika Home dipilih, tidak ada aksi karena sudah di halaman Home
          } else if (index == 1) {
            // Navigasi ke halaman Profile
            Get.toNamed(AppRoutes.INPUT);
          } else if (index == 2) {
            // Panggil metode logout
            controller.logout();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
