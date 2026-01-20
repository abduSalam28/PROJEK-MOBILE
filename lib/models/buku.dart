class Buku {
  final int? id;
  final String kodeBuku;
  final String namaBuku;
  final String pengarang;
  final String penerbit;
  final String tahunTerbit;
  final int jumlahBuku;

  Buku({
    this.id,
    required this.kodeBuku,
    required this.namaBuku,
    required this.pengarang,
    required this.penerbit,
    required this.tahunTerbit,
    required this.jumlahBuku,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      // Mapping kolom database (snake_case) ke variabel Dart (camelCase)
      kodeBuku: json['kode_buku'] ?? '',
      namaBuku: json['nama_buku'] ?? '',
      pengarang: json['pengarang'] ?? '',
      penerbit: json['penerbit'] ?? '',
      tahunTerbit: json['tahun_terbit'] ?? '',
      jumlahBuku: int.parse(json['jumlah_buku'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_buku': kodeBuku,
      'nama_buku': namaBuku,
      'pengarang': pengarang,
      'penerbit': penerbit,
      'tahun_terbit': tahunTerbit,
      'jumlah_buku': jumlahBuku,
    };
  }
}