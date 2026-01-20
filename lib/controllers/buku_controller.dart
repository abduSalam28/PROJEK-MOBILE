import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/buku.dart';

class BukuController extends GetxController {
  var bukuList = <Buku>[].obs;
  var isLoading = true.obs;

  // GUNAKAN IP INI AGAR AMAN DI BROWSER & EMULATOR (JANGAN PAKAI HTTPS)
  final String apiUrl = 'http://service2310020103.test/api/bukus';

  @override
  void onInit() {
    super.onInit();
    fetchBuku();
  }

  // 1. AMBIL DATA (GET)
  Future<void> fetchBuku() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Cek format data, kadang Laravel membungkus dengan {"data": [...]}
        final dynamic jsonResponse = json.decode(response.body);
        List<dynamic> data;
        
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('data')) {
           data = jsonResponse['data'];
        } else {
           data = jsonResponse;
        }

        bukuList.value = data.map((item) => Buku.fromJson(item)).toList();
      } else {
        print("Gagal ambil data: ${response.body}");
      }
    } catch (e) {
      print("Error Fetch: $e");
    } finally {
      isLoading(false);
    }
  }

  // 2. TAMBAH DATA (POST)
  Future<void> addBuku(Buku buku) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(buku.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        fetchBuku(); // Refresh list
        Get.back();
        Get.snackbar("Sukses", "Buku berhasil ditambahkan");
      } else {
        Get.snackbar("Error", "Gagal menyimpan: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  // 3. UPDATE DATA (PUT)
  Future<void> updateBuku(int id, Buku buku) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(buku.toJson()),
      );

      if (response.statusCode == 200) {
        fetchBuku();
        Get.back();
        Get.snackbar("Sukses", "Data Buku berhasil diubah");
      } else {
        Get.snackbar("Error", "Gagal update: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  // 4. HAPUS DATA (DELETE)
  Future<void> deleteBuku(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        fetchBuku();
        Get.snackbar("Sukses", "Buku berhasil dihapus");
      } else {
        Get.snackbar("Error", "Gagal menghapus");
      }
    } catch (e) {
      print("Error Delete: $e");
    }
  }
}