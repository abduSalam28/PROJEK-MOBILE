import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pengguna_buku.dart';

class PenggunaBukuController extends GetxController {
  var peminjamanList = <PenggunaBuku>[].obs;
  var isLoading = true.obs;

  // Gunakan IP 127.0.0.1 agar aman di browser & emulator
  final String apiUrl = 'http://service2310020103.test/api/pengguna_bukus';

  @override
  void onInit() {
    super.onInit();
    fetchPenggunaBuku();
  }

  // GET DATA
  Future<void> fetchPenggunaBuku() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        List<dynamic> data;
        
        // Cek apakah dibungkus "data" (Standard Resource Laravel)
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
           data = jsonResponse['data'];
        } else {
           data = jsonResponse;
        }

        peminjamanList.value = data.map((item) => PenggunaBuku.fromJson(item)).toList();
      } else {
        print("Gagal ambil data: ${response.body}");
      }
    } catch (e) {
      print("Error Fetch: $e");
    } finally {
      isLoading(false);
    }
  }

  // TAMBAH DATA
  Future<void> addPenggunaBuku(PenggunaBuku data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        fetchPenggunaBuku();
        Get.back();
        Get.snackbar("Sukses", "Data Peminjaman berhasil ditambahkan");
      } else {
        Get.snackbar("Error", "Gagal server: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  // UPDATE DATA
  Future<void> updatePenggunaBuku(int id, PenggunaBuku data) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 200) {
        fetchPenggunaBuku();
        Get.back();
        Get.snackbar("Sukses", "Data berhasil diubah");
      } else {
        Get.snackbar("Error", "Gagal update: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  // HAPUS DATA
  Future<void> deletePenggunaBuku(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        fetchPenggunaBuku();
        Get.snackbar("Sukses", "Data berhasil dihapus");
      } else {
        Get.snackbar("Error", "Gagal menghapus: ${response.body}");
      }
    } catch (e) {
      print("Error Delete: $e");
    }
  }
}