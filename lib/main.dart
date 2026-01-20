import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Pastikan baris ini sesuai dengan nama file di folder views kamu
import 'views/buku_view.dart'; 
import 'views/tambah_buku.dart';
import 'views/ubah_buku.dart';

import 'views/pengguna_buku_view.dart';
import 'views/tambah_pengguna_buku.dart';
import 'views/ubah_pengguna_buku.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Data Pengguna View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Memanggil halaman BukuView yang ada di file buku_view.dart
      home: BukuView(),
    );
  }
}