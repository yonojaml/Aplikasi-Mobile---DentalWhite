// Mengimpor pustaka material Flutter
import 'package:flutter/material.dart';
// Mengimpor pustaka shared_preferences untuk menyimpan data secara lokal
import 'package:shared_preferences/shared_preferences.dart';

// Definisi kelas LoginPage sebagai widget stateful
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// State untuk LoginPage
class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengontrol input teks username
  final _usernameController = TextEditingController();
  // Controller untuk mengontrol input teks password
  final _passwordController = TextEditingController();

  // Fungsi untuk proses login
  Future<void> _login() async {
    // Mendapatkan instance SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Mendapatkan username yang tersimpan dari SharedPreferences
    final storedUsername = prefs.getString('username');
    // Mendapatkan password yang tersimpan dari SharedPreferences
    final storedPassword = prefs.getString('password');

    // Memeriksa apakah username dan password yang diinput sesuai dengan yang tersimpan
    if (_usernameController.text == storedUsername && _passwordController.text == storedPassword) {
      // Jika sesuai, navigasi ke halaman home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Jika tidak sesuai, tampilkan SnackBar dengan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
          backgroundColor: Colors.red, // Tambahkan warna merah ke SnackBar
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman
    return Scaffold(
      // AppBar di bagian atas halaman dengan judul dan warna latar belakang
      appBar: AppBar(
        title: Text('DENTAL WHITE'),
        backgroundColor: Colors.blue[800],
      ),
      // Body dari Scaffold dengan padding di sekitar konten
      body: Padding(
        padding: EdgeInsets.all(16.0),
        // Kolom untuk menyusun widget secara vertikal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan kolom di tengah secara vertikal
          children: [
            // Teks judul "Login" dengan gaya tertentu
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            // Kotak kosong untuk memberikan jarak vertikal sebesar 20
            SizedBox(height: 20),
            // Input teks untuk username dengan dekorasi
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            // Kotak kosong untuk memberikan jarak vertikal sebesar 10
            SizedBox(height: 10),
            // Input teks untuk password dengan dekorasi dan menyembunyikan teks
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true, // Menyembunyikan teks yang diinput
            ),
            // Kotak kosong untuk memberikan jarak vertikal sebesar 20
            SizedBox(height: 20),
            // Tombol ElevatedButton untuk proses login
            ElevatedButton(
              onPressed: _login, // Memanggil fungsi _login saat ditekan
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white), // Warna teks putih
              ),
              // Mengatur gaya tombol
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800], // Warna latar belakang tombol
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
