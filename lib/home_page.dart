import 'package:aplikasi/schedule_list_page.dart'; // Mengimpor kelas ScheduleListPage
import 'package:flutter/material.dart'; // Mengimpor paket Material Flutter
import 'package:url_launcher/url_launcher.dart'; // Mengimpor paket url_launcher
import 'package:carousel_slider/carousel_slider.dart'; // Mengimpor paket Carousel Slider
import 'login_page.dart'; // Mengimpor kelas LoginPage
import 'profile_page.dart'; // Mengimpor kelas ProfilePage
import 'doctors_list_page.dart'; // Mengimpor kelas DoctorsListPage
import 'biodata_page.dart'; // Mengimpor kelas BiodataPage
import 'hospital_list_page.dart'; // Mengimpor kelas HospitalListPage
import 'chat_room_page.dart'; // Mengimpor kelas ChatRoomPage

class MyApp extends StatelessWidget { // Mendefinisikan widget stateless
  @override
  Widget build(BuildContext context) { // Metode build untuk mendefinisikan UI
    return MaterialApp(
      title: 'Flutter Demo', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema utama aplikasi
      ),
      home: HomePage(), // Halaman utama aplikasi
    );
  }
}

class HomePage extends StatefulWidget { // Mendefinisikan widget stateful
  @override
  _HomePageState createState() => _HomePageState(); // Membuat state untuk widget ini
}

class _HomePageState extends State<HomePage> { // Mendefinisikan kelas state
  int _selectedIndex = 0; // Indeks halaman yang dipilih saat ini

  static final List<Widget> _pages = <Widget>[ // Daftar halaman yang akan ditampilkan
    HomeContent(), // Konten halaman utama
    ScheduleListPage(), // Halaman daftar janji temu
    ChatBoxPage(), // Halaman kotak obrolan
    BiodataPage(), // Halaman biodata
  ];

  void _onItemTapped(int index) { // Metode untuk menangani ketukan item di BottomNavigationBar
    setState(() {
      _selectedIndex = index; // Mengubah indeks halaman yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) { // Metode build untuk mendefinisikan UI
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang Scaffold
      appBar: AppBar(
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
        elevation: 0, // Elevasi AppBar
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Padding di sekitar leading
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()), // Navigasi ke halaman profil
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'), // Gambar profil
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke awal
          children: [
            Text('Maurent', style: TextStyle(color: Colors.white)), // Nama pengguna
            Text('We are happy to see you again', style: TextStyle(color: Colors.white70, fontSize: 12)), // Pesan sambutan
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white), // Ikon notifikasi
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white), // Ikon logout
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Navigasi ke halaman login
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman berdasarkan indeks yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ikon halaman utama
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Ikon kalender
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Ikon obrolan
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Ikon profil
            label: '',
          ),
        ],
        currentIndex: _selectedIndex, // Indeks halaman yang dipilih saat ini
        selectedItemColor: Colors.blue, // Warna ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon yang tidak dipilih
        onTap: _onItemTapped, // Metode untuk menangani ketukan item
      ),
    );
  }
}

class ChatBoxPage extends StatelessWidget { // Mendefinisikan widget stateless
  @override
  Widget build(BuildContext context) { // Metode build untuk mendefinisikan UI
    WidgetsBinding.instance.addPostFrameCallback((_) { // Menambahkan callback setelah frame di-build
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomPage(
            doctorName: 'Dr. Smith', // Nama dokter
            patientName: 'John Doe', // Nama pasien
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Box'), // Judul AppBar
      ),
      body: Center(
        child: CircularProgressIndicator(), // Menampilkan indikator loading
      ),
    );
  }
}

class HomeContent extends StatelessWidget { // Mendefinisikan widget stateless
  @override
  Widget build(BuildContext context) { // Metode build untuk mendefinisikan UI
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di sekitar konten
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke awal
          children: [
            Text(
              'Selamat Datang! Enjoy your DentalWhite!', // Pesan sambutan
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10), // Jarak antara elemen
            _buildUsageCarousel(), // Menampilkan carousel
            SizedBox(height: 20), // Jarak antara elemen
            Text(
              'Aktivitas', // Judul bagian aktivitas
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10), // Jarak antara elemen
            _buildSpecialityGrid(context), // Menampilkan grid spesialisasi
            SizedBox(height: 20), // Jarak antara elemen
            Text(
              'Artikel Gigi', // Judul bagian artikel
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10), // Jarak antara elemen
            _buildArticleGrid(context), // Menampilkan grid artikel
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialityGrid(BuildContext context) { // Metode untuk membangun grid spesialisasi
    return GridView.count(
      crossAxisCount: 3, // Jumlah kolom
      shrinkWrap: true, // Menyusutkan grid agar sesuai konten
      physics: NeverScrollableScrollPhysics(), // Menonaktifkan scroll
      childAspectRatio: 0.8, // Rasio aspek anak grid
      mainAxisSpacing: 10, // Jarak antara baris
      crossAxisSpacing: 10, // Jarak antara kolom
      children: [
        _buildSpecialityCard('Nama Dokter', 'assets/doctor.jpg', context, DoctorsListPage()), // Kartu spesialisasi dokter
        _buildSpecialityCard('Rumah Sakit Rujukan', 'assets/hospital.jpg', context, HospitalListPage()), // Kartu spesialisasi rumah sakit
        _buildSpecialityCard('Klinik Gigi', 'assets/klinik.jpeg', context, MyApp()), // Kartu spesialisasi klinik gigi
      ],
    );
  }

  Widget _buildArticleGrid(BuildContext context) { // Metode untuk membangun grid artikel
    return Container(
      height: 500, // Tinggi grid
      child: GridView.count(
        crossAxisCount: 2, // Jumlah kolom
        shrinkWrap: true, // Menyusutkan grid agar sesuai konten
        physics: NeverScrollableScrollPhysics(), // Menonaktifkan scroll
        mainAxisSpacing: 10, // Jarak antara baris
        crossAxisSpacing: 10, // Jarak antara kolom
        children: [
          _buildArticleCard(
            context,
            'Yuk, Jaga Kesehatan Gigi dan Gusi dengan Pasta Gigi yang Tepat', // Judul artikel
            'assets/article1.jpg', // Gambar artikel
            'Rutin menyikat gigi memang penting untuk menjaga kesehatan gigi dan gusi. Lalu, bagaimana pasta gigi...', // Ringkasan artikel
            'https://www.alodokter.com/yuk-jaga-kesehatan-gigi-dan-gusi-dengan-pasta-gigi-yang-tepat', // URL artikel
          ),
          _buildArticleCard(
            context,
            'Gosok Gigi Saat Puasa, Ini Waktu Terbaik dan Tips Melakukannya', // Judul artikel
            'assets/article2.jpg', // Gambar artikel
            'Gosok gigi saat puasa boleh dilakukan, kok, asalkan dengan cara yang benar. Nah, supaya gigi dan...', // Ringkasan artikel
            'https://www.alodokter.com/gosok-gigi-saat-puasa-ini-waktu-terbaik-dan-tips-melakukannya', // URL artikel
          ),
          _buildArticleCard(
            context,
            'Mengenal Dokter Gigi dan Kapan Harus Memeriksakan Gigi', // Judul artikel
            'assets/article3.jpg', // Gambar artikel
            'Dokter gigi adalah seorang dokter yang fokus pada kesehatan gigi dan mulut. Mereka berperan dalam...', // Ringkasan artikel
            'https://www.alodokter.com/mengenal-dokter-gigi-dan-kapan-saatnya-memeriksakan-gigi', // URL artikel
          ),
          _buildArticleCard(
            context,
            'Tips Menjaga Kebersihan Gigi dan Mulut di Masa Pandemi', // Judul artikel
            'assets/article4.jpg', // Gambar artikel
            'Selama pandemi, menjaga kebersihan gigi dan mulut menjadi semakin penting. Berikut beberapa tips...', // Ringkasan artikel
            'https://www.alodokter.com/tips-aman-menyikat-gigi-anak', // URL artikel
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialityCard(String title, String imagePath, BuildContext context, Widget page) { // Metode untuk membangun kartu spesialisasi
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bentuk kartu
      elevation: 4, // Elevasi kartu
      color: Colors.white, // Warna latar belakang kartu
      child: InkWell(
        borderRadius: BorderRadius.circular(8), // Radius border untuk animasi
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page), // Navigasi ke halaman terkait
          );
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover), // Gambar kartu
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding di sekitar teks
              child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)), // Judul kartu
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, String title, String imagePath, String summary, String url) { // Metode untuk membangun kartu artikel
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bentuk kartu
      elevation: 4, // Elevasi kartu
      color: Colors.white, // Warna latar belakang kartu
      child: InkWell(
        borderRadius: BorderRadius.circular(8), // Radius border untuk animasi
        onTap: () {
          _launchURL(url); // Meluncurkan URL artikel
        },
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover), // Gambar artikel
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding di sekitar teks
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke awal
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)), // Judul artikel
                  SizedBox(height: 5), // Jarak antara elemen
                  Text(summary, style: TextStyle(fontSize: 12, color: Colors.black54)), // Ringkasan artikel
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async { // Metode untuk meluncurkan URL
    if (await canLaunch(url)) { // Memeriksa apakah URL dapat diluncurkan
      await launch(url); // Meluncurkan URL
    } else {
      throw 'Could not launch $url'; // Membuang kesalahan jika URL tidak dapat diluncurkan
    }
  }

  Widget _buildUsageCarousel() { // Metode untuk membangun carousel penggunaan
    final List<Widget> usageSteps = [
      _buildUsageStep(
        'Membersihkan Karang Gigi secara efektif dan mudah. Tidak perlu membayar mahal!', // Deskripsi penggunaan
        'assets/carousel1.jpg', // Gambar carousel
      ),
      _buildUsageStep(
        'Gigi tampak rapi dengan memasang behel! Pilih warna behel kesukaan Anda!', // Deskripsi penggunaan
        'assets/carousel2.jpg', // Gambar carousel
      ),
      _buildUsageStep(
        'Atasi rasa nyeri gigi berlubang tanpa rasa sakit. Coba sekarang!', // Deskripsi penggunaan
        'assets/carousel3.jpg', // Gambar carousel
      ),
    ];

    return CarouselSlider(
      items: usageSteps, // Item carousel
      options: CarouselOptions(
        autoPlay: true, // Pengaturan autoplay
        enlargeCenterPage: true, // Pengaturan untuk memperbesar halaman tengah
        aspectRatio: 2.0, // Rasio aspek
        onPageChanged: (index, reason) {}, // Callback saat halaman berubah
      ),
    );
  }

  Widget _buildUsageStep(String description, String imagePath) { // Metode untuk membangun langkah penggunaan
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bentuk kartu
      elevation: 4, // Elevasi kartu
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(imagePath, width: double.infinity, fit: BoxFit.cover), // Gambar langkah penggunaan
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), // Padding di sekitar teks
            child: Text(description, style: TextStyle(fontSize: 14, color: Colors.black)), // Deskripsi langkah penggunaan
          ),
        ],
      ),
    );
  }
}
