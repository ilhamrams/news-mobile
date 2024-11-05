import 'package:berita/app/modules/home/views/detail_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_routes.dart'; // Pastikan DetailNewsView diimport

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Get.offNamed(AppRoutes.HOME); // Reset seluruh halaman Home
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh:
                controller.refreshBeritas, // Fungsi refresh di controller
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Tampilkan 2 kolom
                childAspectRatio: 0.8, // Sesuaikan rasio lebar dan tinggi
              ),
              itemCount: controller.beritas.length,
              itemBuilder: (context, index) {
                final berita = controller.beritas[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailNewsView(berita: berita));
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    color:
                        Colors.grey[100], // Warna background card yang lembut
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar dengan ukuran tetap (1:1 ratio) dan berbentuk kotak
                        Container(
                          width: double.infinity,
                          height: 140.0, // Tinggi tetap untuk 1:1 ratio
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors
                                .grey[300], // Background jika gambar gagal
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              berita.gambar,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.broken_image,
                                          size: 40, color: Colors.grey[600]),
                                      Text(
                                        'Gambar tidak tersedia',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Judul tanpa padding bawah
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0),
                          child: Text(
                            berita.judul,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
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
            // Navigasi ke halaman Input
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
            icon: Icon(Icons.input),
            label: 'Input',
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
