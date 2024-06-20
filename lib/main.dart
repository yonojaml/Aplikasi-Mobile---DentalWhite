import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import halaman sambutan
import 'login_page.dart'; // Import halaman login
import 'signup_page.dart'; // Import halaman pendaftaran
import 'home_page.dart' as Home; // Import home_page.dart dengan alias Home
import 'profile_page.dart'; // Import halaman profil
import 'doctors_list_page.dart'; // Import halaman daftar dokter
import 'hospital_list_page.dart'; // Import halaman daftar rumah sakit
import 'chat_room_page.dart'; // Import halaman ruang obrolan
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'firebase_options.dart'; // Import opsi Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan bahwa binding flutter telah diinisialisasi
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inisialisasi Firebase dengan opsi default
  runApp(DentalWhiteApp()); // Jalankan aplikasi DentalWhiteApp
}

// Kelas utama aplikasi Dental White
class DentalWhiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental White', // Judul aplikasi
      initialRoute: '/', // Rute awal aplikasi
      routes: {
        '/': (context) => WelcomePage(), // Rute untuk halaman sambutan
        '/login': (context) => LoginPage(), // Rute untuk halaman login
        '/signup': (context) => SignupPage(), // Rute untuk halaman pendaftaran
        '/home': (context) => Home.HomePage(), // Gunakan alias untuk merujuk ke HomePage
        '/profile': (context) => ProfilePage(), // Rute untuk halaman profil
        '/doctors': (context) => DoctorsListPage(), // Rute untuk halaman daftar dokter
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') { // Jika rute adalah '/chat'
          return MaterialPageRoute(
            builder: (context) => ChatRoomPage(
              doctorName: 'Dr. Smith',
              patientName: 'John Doe',
            ),
          );
        }
        return null; // Kembalikan null jika rute tidak cocok
      },
    );
  }
}

// Kelas HomePage untuk halaman utama
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'), // Judul AppBar
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Chat Room'), // Tombol untuk pergi ke ruang obrolan
          onPressed: () {
            Navigator.pushNamed(context, '/chat'); // Navigasi ke ChatRoomPage
          },
        ),
      ),
    );
  }
}
