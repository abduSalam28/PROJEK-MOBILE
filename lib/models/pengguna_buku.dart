class PenggunaBuku {
  final int? id;
  final String noPinjam;
  final int bukuId;
  final String tanggalPeminjaman;
  final String tanggalPengembalian;

  PenggunaBuku({
    this.id,
    required this.noPinjam,
    required this.bukuId,
    required this.tanggalPeminjaman,
    required this.tanggalPengembalian,
  });

  factory PenggunaBuku.fromJson(Map<String, dynamic> json) {
    return PenggunaBuku(
      id: json['id'],
      noPinjam: json['no_pinjam'] ?? '',
      // Pastikan konversi ke int aman
      bukuId: int.tryParse(json['buku_id'].toString()) ?? 0,
      tanggalPeminjaman: json['tanggal_peminjaman'] ?? '',
      tanggalPengembalian: json['tanggal_pengembalian'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no_pinjam': noPinjam,
      'buku_id': bukuId,
      'tanggal_peminjaman': tanggalPeminjaman,
      'tanggal_pengembalian': tanggalPengembalian,
    };
  }
}