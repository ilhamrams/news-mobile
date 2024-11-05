// ignore_for_file: use_key_in_widget_constructors

import 'package:berita/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addberita_controller.dart';

class BeritaForm extends StatelessWidget {
  final AddBerita controller = Get.find<AddBerita>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Berita'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              // Refresh data kategori
              controller.resetForm(); // Reset form setelah refresh
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(() => DropdownButtonFormField<int>(
                    value: controller.selectedKategoriId.value == 0
                        ? null
                        : controller.selectedKategoriId.value,
                    items: controller.kategoriList.map((kategori) {
                      return DropdownMenuItem<int>(
                        value: kategori.id,
                        child: Text(kategori.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedKategoriId.value = value!;
                    },
                    decoration: InputDecoration(labelText: 'Pilih Kategori'),
                    validator: (value) {
                      if (value == null) {
                        return 'Kategori harus dipilih';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 20),
              Obx(() {
                return controller.selectedImage.value == null
                    ? Text("Tidak ada gambar dipilih")
                    : Image.file(controller.selectedImage.value!, height: 150);
              }),
              ElevatedButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Pilih Gambar"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.artikelController,
                decoration: InputDecoration(labelText: 'Artikel'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Artikel harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.insertBerita();
                        }
                      },
                      child: Text('Simpan'),
                    )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(AppRoutes.HOME);
          } else if (index == 1) {
          } else if (index == 2) {
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
