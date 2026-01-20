import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pengguna_buku_controller.dart';
import '../models/pengguna_buku.dart';

class UbahPenggunaBukuView extends StatefulWidget {
  final PenggunaBuku penggunaBuku;
  const UbahPenggunaBukuView({super.key, required this.penggunaBuku});

  @override
  State<UbahPenggunaBukuView> createState() => _UbahPenggunaBukuViewState();
}

class _UbahPenggunaBukuViewState extends State<UbahPenggunaBukuView> {
  final PenggunaBukuController controller = Get.find();

  late TextEditingController noPinjamController;
  late TextEditingController bukuIdController;
  late TextEditingController tglPinjamController;
  late TextEditingController tglKembaliController;

  @override
  void initState() {
    super.initState();
    noPinjamController = TextEditingController(text: widget.penggunaBuku.noPinjam);
    bukuIdController = TextEditingController(text: widget.penggunaBuku.bukuId.toString());
    tglPinjamController = TextEditingController(text: widget.penggunaBuku.tanggalPeminjaman);
    tglKembaliController = TextEditingController(text: widget.penggunaBuku.tanggalPengembalian);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Peminjaman")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: noPinjamController,
              decoration: const InputDecoration(labelText: "No Pinjam"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bukuIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "ID Buku"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tglPinjamController,
              decoration: const InputDecoration(labelText: "Tanggal Peminjaman"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tglKembaliController,
              decoration: const InputDecoration(labelText: "Tanggal Pengembalian"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  final updatedData = PenggunaBuku(
                    id: widget.penggunaBuku.id,
                    noPinjam: noPinjamController.text,
                    bukuId: int.tryParse(bukuIdController.text) ?? 0,
                    tanggalPeminjaman: tglPinjamController.text,
                    tanggalPengembalian: tglKembaliController.text,
                  );

                  controller.updatePenggunaBuku(widget.penggunaBuku.id!, updatedData);
                },
                child: const Text("Simpan Perubahan", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}