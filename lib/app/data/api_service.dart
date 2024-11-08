// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'models/berita.dart';
import 'models/kategori.dart';
import 'models/login_response.dart';

class ApiService {
  final String _baseUrl = 'https://ilham.alinea-api.my.id/api/';
  final GetStorage storage = GetStorage();

  // Fetch data berita
  Future<List<Berita>> fetchBeritas() async {
    try {
      String? token = storage.read('auth_token');

      final response = await http.get(
        Uri.parse('$_baseUrl/beritas'),
        headers: {
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'Keep-Alive',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['data'] != null && jsonData['data']['beritas'] != null) {
          List data = jsonData['data']['beritas'];
          return data.map((berita) => Berita.fromJson(berita)).toList();
        } else {
          throw Exception('Data key not found in response');
        }
      } else {
        throw Exception(
            'Failed to load data with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }

  // Insert berita baru
  Future<void> insertBerita(Berita berita, File? imageFile) async {
    try {
      String? token = storage.read('auth_token');

      // Buat MultipartRequest
      var uri = Uri.parse('$_baseUrl/beritas');
      var request = http.MultipartRequest('POST', uri);

      // Tambahkan header authorization
      request.headers.addAll({
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'Keep-Alive',
        'Authorization': 'Bearer $token',
      });

      // Tambahkan data berita sebagai fields
      request.fields['id_kategori'] =
          berita.idKategori.toString(); // Pastikan nama field ini sesuai
      request.fields['judul'] = berita.judul;
      request.fields['artikel'] = berita.artikel;

      // Jika ada gambar, tambahkan sebagai file
      if (imageFile != null) {
        var fileStream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'gambar', // Pastikan nama field ini sesuai dengan yang diharapkan API
          fileStream,
          length,
          filename: basename(
              imageFile.path), // Menggunakan basename dari package `path`
        );

        request.files.add(multipartFile);
      }

      // Kirim request dan tunggu respons
      var response = await request.send();

      // Handle response
      if (response.statusCode == 201) {
        print('Berita berhasil disimpan');
      } else {
        // Untuk debugging, tampilkan body response jika terjadi kesalahan
        var responseData = await response.stream.bytesToString();
        print(
            'Response body: $responseData'); // Menampilkan respons dari server
        throw Exception(
            'Gagal menyimpan data dengan status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error inserting data: $e');
      rethrow;
    }
  }

  // Delete berita
  Future<void> deleteBerita(int beritaId) async {
    try {
      String? token = storage.read('auth_token');

      final response = await http.delete(
        Uri.parse('$_baseUrl/beritas/$beritaId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to delete data with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting data: $e');
      rethrow;
    }
  }

  // kategori Berita
  Future<List<Kategori>> fetchKategoris() async {
    try {
      String? token = storage.read('auth_token');

      final response = await http.get(
        Uri.parse('$_baseUrl/kategoris'),
        headers: {
          // 'Accept-Encoding': 'gzip, deflate, br',
          // 'Connection': 'Keep-Alive',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['data'] != null && jsonData['data']['kategoris'] != null) {
          List data = jsonData['data']['kategoris'];
          return data.map((kategori) => Kategori.fromJson(kategori)).toList();
        } else {
          throw Exception('Data key not found in response');
        }
      } else {
        throw Exception(
            'Failed to load data with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }

  // Login
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Login failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
  }
}
