// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../../app/data/api_service.dart';
import '../../../../app/data/models/berita.dart';
import '../../../../app/data/models/kategori.dart';

class AddBerita extends GetxController {
  final ApiService _apiService = ApiService();
  RxList<Kategori> kategoriList = <Kategori>[].obs;
  RxInt selectedKategoriId = 0.obs;
  var isLoading = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null); // Tambahkan variabel untuk gambar

  // TextEditingControllers untuk form input
  final TextEditingController judulController = TextEditingController();
  final TextEditingController artikelController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchKategoriList();
  }

  // Fungsi untuk menyimpan berita
  Future<void> insertBerita() async {
    if (_validateForm()) {
      isLoading.value = true;

      // Pastikan `selectedImage` sudah memiliki file gambar yang dipilih
      if (selectedImage.value == null) {
        Get.snackbar('Error', 'Silakan pilih gambar');
        isLoading.value = false;
        return;
      }

      // Buat objek berita dengan menggunakan selectedKategoriId dan path gambar
      final berita = Berita(
        id: 0,
        idKategori: selectedKategoriId.value,
        judul: judulController.text,
        artikel: artikelController.text,
        gambar: basename(
            selectedImage.value!.path), // Sertakan path gambar yang dipilih
      );

      // Cetak data yang akan dikirim
      print('Data yang dikirim:');
      print('ID Kategori: ${berita.idKategori}');
      print('Judul: ${berita.judul}');
      print('Artikel: ${berita.artikel}');
      print('Path Gambar: ${berita.gambar}');

      try {
        await _apiService.insertBerita(berita, selectedImage.value);
        Get.snackbar('Success', 'Berita berhasil disimpan');
        clearForm();
      } catch (e) {
        Get.snackbar('Error', 'Gagal menyimpan berita: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Fungsi untuk mengambil gambar dari galeri
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void fetchKategoriList() async {
    try {
      isLoading.value = true;
      var response = await _apiService.fetchKategoris();
      kategoriList.assignAll(response);
    } catch (e) {
      print("Error fetching kategori list: $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateForm() {
    if (selectedKategoriId.value == 0 ||
        selectedImage.value == null || // Validasi agar gambar tidak null
        judulController.text.isEmpty ||
        artikelController.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }
    return true;
  }

  void clearForm() {
    selectedKategoriId.value = 0;
    selectedImage.value = null;
    judulController.clear();
    artikelController.clear();
  }

  @override
  void onClose() {
    judulController.dispose();
    artikelController.dispose();
    super.onClose();
  }

  void logout() {}
}
