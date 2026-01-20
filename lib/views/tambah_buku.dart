import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buku_controller.dart';
import '../models/buku.dart';

class TambahBukuView extends StatelessWidget {
  final BukuController controller = Get.find();

  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController pengarangController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();

  TambahBukuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Buku Baru")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: kodeController,
              decoration: const InputDecoration(labelText: "Kode Buku (misal: BUK01)"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama Buku"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pengarangController,
              decoration: const InputDecoration(labelText: "Pengarang"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: penerbitController,
              decoration: const InputDecoration(labelText: "Penerbit"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tahunController,
              decoration: const InputDecoration(labelText: "Tahun Terbit (YYYY-MM-DD)"),
              // Hint: Sebaiknya pakai DatePicker, tapi pakai text dulu biar mudah
            ),
            const SizedBox(height: 10),
            TextField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Jumlah Buku (Angka)"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validasi sederhana
                  if (kodeController.text.isEmpty || namaController.text.isEmpty) {
                    Get.snackbar("Error", "Kode dan Nama Buku wajib diisi");
                    return;
                  }

                  final buku = Buku(
                    kodeBuku: kodeController.text,
                    namaBuku: namaController.text,
                    pengarang: pengarangController.text,
                    penerbit: penerbitController.text,
                    tahunTerbit: tahunController.text,
                    jumlahBuku: int.tryParse(jumlahController.text) ?? 0,
                  );

                  controller.addBuku(buku);
                },
                child: const Text("Simpan Data"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}