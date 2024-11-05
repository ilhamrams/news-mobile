class Berita {
  final int id;
  final int idKategori;
  final String gambar;
  final String judul;
  final String artikel;
  final DateTime createdAt;

  Berita({
    required this.id,
    required this.idKategori,
    required this.gambar,
    required this.judul,
    required this.artikel,
    required this.createdAt,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'],
      idKategori: json['id_kategori'],
      gambar: json['gambar_url'],
      judul: json['judul'],
      artikel: json['artikel'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Metode toJson untuk mengonversi objek Berita menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_kategori': idKategori,
      'gambar': gambar,
      'judul': judul,
      'artikel': artikel,
    };
  }
}
