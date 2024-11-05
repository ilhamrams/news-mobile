import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/berita.dart';

class DetailNewsView extends StatelessWidget {
  final Berita berita; // Object passed from the previous page

  const DetailNewsView({super.key, required this.berita});

  String formatArtikel(String text) {
    // Mengganti setiap tag <p> atau </p> dengan baris baru
    return text.replaceAll(RegExp(r'</?p>'), '\n').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Berita'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
            Container(
              width: double.infinity,
              height: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  berita.gambar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image,
                              size: 40, color: Colors.grey[600]),
                          Text(
                            'Gambar tidak tersedia',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),

            // Title
            Text(
              berita.judul,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),

            // Date
            Text(
              DateFormat('dd-MM-yyyy').format(berita.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.0),

            // Article content with formatted HTML
            Text(
              formatArtikel(berita.artikel), // Gunakan formatArtikel di sini
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify, // Justify alignment
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
