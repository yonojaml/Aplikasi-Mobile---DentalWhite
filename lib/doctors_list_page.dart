import 'package:flutter/material.dart'; // Mengimpor package Material dari Flutter
import 'doctor_detail_page.dart'; // Mengimpor halaman detail dokter

class DoctorsListPage extends StatelessWidget { // Membuat class DoctorsListPage yang merupakan StatelessWidget
  @override
  Widget build(BuildContext context) { // Method build untuk membuat UI
    return Scaffold( // Menggunakan Scaffold sebagai struktur utama halaman
      appBar: AppBar( // Membuat AppBar
        title: Text('Daftar Dokter'), // Judul AppBar
      ),
      body: SingleChildScrollView( // Membuat body yang bisa di-scroll
        child: Padding( // Padding untuk memberi ruang di sekitar child
          padding: const EdgeInsets.all(8.0), // Padding dengan jarak 8.0
          child: Column( // Menggunakan Column untuk menata widgets secara vertikal
            children: [
              DoctorCard( // Menambahkan DoctorCard pertama
                name: 'dr. Miselia Ayu Andini',
                imageUrl: 'assets/ayu.jpg',
                email: 'miseliandini@gmail.com',
                address: 'RSUD DR ZAINOEL ABIDIN',
                description: 'At MedLife, we create integrated medical services with the professionality...',
              ),
              DoctorCard( // Menambahkan DoctorCard kedua
                name: 'dr. Satria Putra Pertama',
                imageUrl: 'assets/satria.jpg',
                email: 'satriapertama34@gmail.com',
                address: 'RSUD CUT MEUTIA KAB ACEH UTARA',
                description: 'At MedLife, we create integrated medical services with the professionality...',
              ),
              DoctorCard( // Menambahkan DoctorCard ketiga
                name: 'dr. Eko Susilo Wahyu',
                imageUrl: 'assets/eko.jpg',
                email: 'ekowahyususilo98@gmail.com',
                address: 'RSUP SANGLAH',
                description: 'At MedLife, we create integrated medical services with the professionality...',
              ),
              DoctorCard( // Menambahkan DoctorCard keempat
                name: 'dr. Wahyu Aji Nugraha',
                imageUrl: 'assets/wahyu.jpg',
                email: 'nugrahaaji218@gmail.com',
                address: 'RSUD CUT MEUTIA KAB ACEH UTARA',
                description: 'At MedLife, we create integrated medical services with the professionality...',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget { // Membuat class DoctorCard yang merupakan StatelessWidget
  final String name; // Deklarasi variabel name
  final String imageUrl; // Deklarasi variabel imageUrl
  final String email; // Deklarasi variabel email
  final String address; // Deklarasi variabel address
  final String description; // Deklarasi variabel description

  DoctorCard({ // Konstruktor untuk menerima parameter
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.address,
    required this.description,
  });

  @override
  Widget build(BuildContext context) { // Method build untuk membuat UI dari DoctorCard
    return Card( // Menggunakan Card untuk menampung informasi dokter
      margin: EdgeInsets.symmetric(vertical: 10), // Margin vertikal 10
      child: Padding( // Padding di dalam Card
        padding: const EdgeInsets.all(8.0), // Padding dengan jarak 8.0
        child: Column( // Menggunakan Column untuk menata widgets secara vertikal
          crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment widget di dalam Column
          children: [
            Row( // Menggunakan Row untuk menata widget secara horizontal
              children: [
                Image.asset( // Menampilkan gambar dari asset
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10), // Memberikan jarak horizontal 10
                Expanded( // Membuat widget child bisa expand
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5), // Memberikan jarak vertikal 5
                      Text('Address: $address'),
                      SizedBox(height: 5),
                      Text('Email: $email'),
                      SizedBox(height: 5),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis, // Menampilkan teks dengan ellipsis jika terlalu panjang
                        maxLines: 2, // Menampilkan maksimal 2 baris
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Memberikan jarak vertikal 10
            OutlinedButton( // Membuat tombol OutlinedButton
              onPressed: () { // Fungsi yang dipanggil saat tombol ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDetailPage(
                      name: name,
                      imageUrl: imageUrl,
                      address: address,
                      description: description,
                    ),
                  ),
                );
              },
              child: Text('More'), // Teks tombol
            ),
          ],
        ),
      ),
    );
  }
}
