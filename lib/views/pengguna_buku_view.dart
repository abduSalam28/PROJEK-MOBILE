import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pengguna_buku_controller.dart';
import 'tambah_pengguna_buku.dart';
import 'ubah_pengguna_buku.dart';

class PenggunaBukuView extends StatelessWidget {
  final PenggunaBukuController controller = Get.put(PenggunaBukuController());

  PenggunaBukuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Peminjaman Buku"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchPenggunaBuku(),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.peminjamanList.isEmpty) {
          return const Center(child: Text("Belum ada data peminjaman"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.peminjamanList.length,
          itemBuilder: (context, index) {
            final data = controller.peminjamanList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.book_online, color: Colors.blue),
                ),
                title: Text(
                  "No Pinjam: ${data.noPinjam}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID Buku: ${data.bukuId}"),
                    Text("Tgl Pinjam: ${data.tanggalPeminjaman}"),
                    Text("Tgl Kembali: ${data.tanggalPengembalian}", 
                         style: const TextStyle(color: Colors.red)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => Get.to(() => UbahPenggunaBukuView(penggunaBuku: data)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Hapus",
                          middleText: "Yakin hapus data ${data.noPinjam}?",
                          textConfirm: "Ya",
                          textCancel: "Batal",
                          onConfirm: () {
                            if (data.id != null) controller.deletePenggunaBuku(data.id!);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => TambahPenggunaBukuView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}