import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pengguna_buku_controller.dart';
import '../models/pengguna_buku.dart';

class TambahPenggunaBukuView extends StatelessWidget {
  final PenggunaBukuController controller = Get.find();

  final TextEditingController noPinjamController = TextEditingController();
  final TextEditingController bukuIdController = TextEditingController();
  final TextEditingController tglPinjamController = TextEditingController();
  final TextEditingController tglKembaliController = TextEditingController();

  TambahPenggunaBukuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Peminjaman")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: noPinjamController,
              decoration: const InputDecoration(labelText: "No Pinjam (misal: PIN001)"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bukuIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "ID Buku (Angka)"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tglPinjamController,
              decoration: const InputDecoration(
                labelText: "Tanggal Peminjaman (YYYY-MM-DD)",
                hintText: "Contoh: 2026-01-20"
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tglKembaliController,
              decoration: const InputDecoration(
                labelText: "Tanggal Pengembalian (YYYY-MM-DD)",
                 hintText: "Contoh: 2026-01-27"
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (noPinjamController.text.isEmpty || bukuIdController.text.isEmpty) {
                    Get.snackbar("Error", "No Pinjam dan ID Buku wajib diisi");
                    return;
                  }

                  final newData = PenggunaBuku(
                    noPinjam: noPinjamController.text,
                    bukuId: int.tryParse(bukuIdController.text) ?? 0,
                    tanggalPeminjaman: tglPinjamController.text,
                    tanggalPengembalian: tglKembaliController.text,
                  );

                  controller.addPenggunaBuku(newData);
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