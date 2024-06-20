// Mengimpor pustaka material Flutter
import 'package:flutter/material.dart';
// Mengimpor pustaka shared_preferences untuk menyimpan data secara lokal
import 'package:shared_preferences/shared_preferences.dart';

// Definisi kelas SignupPage sebagai widget stateful
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

// State untuk SignupPage
class _SignupPageState extends State<SignupPage> {
  // Controller untuk mengontrol input teks username
  final _usernameController = TextEditingController();
  // Controller untuk mengontrol input teks email
  final _emailController = TextEditingController();
  // Controller untuk mengontrol input teks password
  final _passwordController = TextEditingController();

  // Fungsi untuk proses pendaftaran
  Future<void> _signup() async {
    // Mendapatkan instance SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Menyimpan username ke SharedPreferences
    await prefs.setString('username', _usernameController.text);
    // Menyimpan email ke SharedPreferences
    await prefs.setString('email', _emailController.text);
    // Menyimpan password ke SharedPreferences
    await prefs.setString('password', _passwordController.text);
    // Menampilkan dialog setelah pendaftaran berhasil
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // Judul dialog
          title: Text('Sign Up Successful'),
          // Konten dialog
          content: Text('Your account has been created successfully.'),
          // Tindakan yang bisa dilakukan di dialog
          actions: <Widget>[
            // Tombol OK
            TextButton(
              onPressed: () {
                // Menutup dialog
                Navigator.of(context).pop();
                // Navigasi ke halaman login
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
            // Teks judul "Buat Akun" dengan gaya tertentu
            Text(
              'Buat Akun',
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
            // Input teks untuk email dengan dekorasi
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
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
            // Tombol ElevatedButton untuk proses pendaftaran
            ElevatedButton(
              onPressed: _signup, // Memanggil fungsi _signup saat ditekan
              child: Text(
                'Buat Akun',
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
