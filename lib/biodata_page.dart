import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Kelas utama aplikasi
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Pembuat Aplikasi', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema warna aplikasi
      ),
      home: BiodataPage(), // Halaman utama aplikasi
    );
  }
}

// Kelas untuk halaman biodata
class BiodataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata Pembuat Aplikasi'), // Judul di AppBar
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Scroll view ke arah horizontal
        child: Row(
          children: [
            // Kartu biodata pertama
            BiodataCard(
              nama: 'Septiono Raka Wahyu Sasongko',
              npm: '22082010071',
              kelas: 'Paralel B',
              linkGithub: 'https://github.com/yonojaml',
              email: '22082010071@student.upnjatim.ac.id',
              foto: 'assets/raka.jpg',
            ),
            SizedBox(width: 16), // Jarak antar kartu
            // Kartu biodata kedua
            BiodataCard(
              nama: 'Diah Pitaloka Rachmawati',
              npm: '22082010053',
              kelas: 'Paralel B',
              linkGithub: 'https://github.com/diahpitaaa',
              email: 'diahpitaaa@gmail.com',
              foto: 'assets/pita.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

// Kelas untuk kartu biodata
class BiodataCard extends StatelessWidget {
  final String nama;
  final String npm;
  final String kelas;
  final String linkGithub;
  final String email;
  final String foto;

  const BiodataCard({
    Key? key,
    required this.nama,
    required this.npm,
    required this.kelas,
    required this.linkGithub,
    required this.email,
    required this.foto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Elevasi kartu untuk memberi efek bayangan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Sudut kartu yang membulat
      ),
      child: Container(
        width: 300, // Lebar tetap untuk kartu
        height: 400, // Tinggi tetap untuk kartu
        padding: const EdgeInsets.all(16), // Padding dalam kartu
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Posisi teks di kiri
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(foto), // Gambar profil
                  radius: 50, // Ukuran avatar
                ),
              ),
              SizedBox(height: 16), // Jarak antar elemen
              Text(
                'Nama:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Teks bold
              ),
              Text(
                nama,
                style: TextStyle(fontSize: 16), // Teks biasa
              ),
              SizedBox(height: 8), // Jarak antar elemen
              Text(
                'NPM:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Teks bold
              ),
              Text(
                npm,
                style: TextStyle(fontSize: 16), // Teks biasa
              ),
              SizedBox(height: 8), // Jarak antar elemen
              Text(
                'Kelas:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Teks bold
              ),
              Text(
                kelas,
                style: TextStyle(fontSize: 16), // Teks biasa
              ),
              SizedBox(height: 8), // Jarak antar elemen
              Text(
                'Link GitHub:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Teks bold
              ),
              InkWell(
                child: Text(
                  linkGithub,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue, // Warna teks biru
                    decoration: TextDecoration.underline, // Garis bawah teks
                  ),
                ),
                onTap: () => _launchURL(linkGithub), // Fungsi saat link diklik
              ),
              SizedBox(height: 8), // Jarak antar elemen
              Text(
                'Email:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Teks bold
              ),
              Text(
                email,
                style: TextStyle(fontSize: 16), // Teks biasa
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuka URL di browser
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url'; // Pesan error jika URL tidak bisa dibuka
    }
  }
}
