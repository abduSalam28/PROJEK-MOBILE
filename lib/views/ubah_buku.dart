import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buku_controller.dart';
import '../models/buku.dart';

class UbahBukuView extends StatefulWidget {
  final Buku buku;
  const UbahBukuView({super.key, required this.buku});

  @override
  State<UbahBukuView> createState() => _UbahBukuViewState();
}

class _UbahBukuViewState extends State<UbahBukuView> {
  final BukuController controller = Get.find();

  late TextEditingController kodeController;
  late TextEditingController namaController;
  late TextEditingController pengarangController;
  late TextEditingController penerbitController;
  late TextEditingController tahunController;
  late TextEditingController jumlahController;

  @override
  void initState() {
    super.initState();
    // Isi form dengan data lama
    kodeController = TextEditingController(text: widget.buku.kodeBuku);
    namaController = TextEditingController(text: widget.buku.namaBuku);
    pengarangController = TextEditingController(text: widget.buku.pengarang);
    penerbitController = TextEditingController(text: widget.buku.penerbit);
    tahunController = TextEditingController(text: widget.buku.tahunTerbit);
    jumlahController = TextEditingController(text: widget.buku.jumlahBuku.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Data Buku")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: kodeController,
              decoration: const InputDecoration(labelText: "Kode Buku"),
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
              decoration: const InputDecoration(labelText: "Tahun Terbit"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Jumlah Buku"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  final updatedBuku = Buku(
                    id: widget.buku.id,
                    kodeBuku: kodeController.text,
                    namaBuku: namaController.text,
                    pengarang: pengarangController.text,
                    penerbit: penerbitController.text,
                    tahunTerbit: tahunController.text,
                    jumlahBuku: int.tryParse(jumlahController.text) ?? 0,
                  );

                  controller.updateBuku(widget.buku.id!, updatedBuku);
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