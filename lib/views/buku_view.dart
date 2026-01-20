import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buku_controller.dart';
import 'tambah_buku.dart';
import 'ubah_buku.dart';

class BukuView extends StatelessWidget {
  final BukuController controller = Get.put(BukuController());

  BukuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Buku"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchBuku(),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.bukuList.isEmpty) {
          return const Center(child: Text("Belum ada data buku"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.bukuList.length,
          itemBuilder: (context, index) {
            final buku = controller.bukuList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(buku.kodeBuku.substring(0, 1)),
                ),
                title: Text(buku.namaBuku, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pengarang: ${buku.pengarang}"),
                    Text("Penerbit: ${buku.penerbit} (${buku.tahunTerbit})"),
                    Text("Stok: ${buku.jumlahBuku}", style: TextStyle(color: Colors.green)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => Get.to(() => UbahBukuView(buku: buku)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Hapus Buku",
                          middleText: "Yakin ingin menghapus ${buku.namaBuku}?",
                          textConfirm: "Ya",
                          textCancel: "Batal",
                          onConfirm: () {
                            if (buku.id != null) controller.deleteBuku(buku.id!);
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
        onPressed: () => Get.to(() => TambahBukuView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}