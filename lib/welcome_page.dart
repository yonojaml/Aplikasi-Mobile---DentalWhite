// Mengimpor pustaka material Flutter
import 'package:flutter/material.dart';

// Definisi kelas WelcomePage yang merupakan widget stateless
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman
    return Scaffold(
      // Body dari Scaffold yang berisi widget Center untuk memusatkan konten
      body: Center(
        // Kolom untuk menyusun widget secara vertikal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan kolom di tengah secara vertikal
          children: [
            // Gambar logo Dental White dengan tinggi 200
            Image.asset('assets/dentalwhite.png', height: 200),
            // Kotak kosong untuk memberikan jarak vertikal sebesar 20
            SizedBox(height: 20),
            // Teks judul "DENTAL WHITE" dengan ukuran font 24 dan tebal
            Text(
              'DENTAL WHITE',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Kotak kosong untuk memberikan jarak vertikal sebesar 10
            SizedBox(height: 10),
            // Teks deskripsi aplikasi dengan rata tengah dan ukuran font 16
            Text(
              'Halo! Kami Siap Membantu\nAnda Merawat Gigi dengan Lebih Baik.\nBersiaplah untuk Senyum Sehat dan Menawan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            // Kotak kosong untuk memberikan jarak vertikal sebesar 20
            SizedBox(height: 20),
            // Tombol ElevatedButton untuk navigasi ke halaman signup
            ElevatedButton(
              onPressed: () {
                // Mengganti halaman saat ini dengan halaman signup
                Navigator.pushReplacementNamed(context, '/signup');
              },
              // Teks di dalam tombol
              child: Text('MULAI SEKARANG'),
            ),
          ],
        ),
      ),
    );
  }
}
