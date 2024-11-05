class Kategori {
  final int id;
  final String name;
  final String description;

  Kategori({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  // Metode toJson untuk mengonversi objek Kategori menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
