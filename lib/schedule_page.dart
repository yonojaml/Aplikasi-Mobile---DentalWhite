import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Kelas SchedulePage sebagai StatelessWidget untuk halaman jadwal janji temu
class SchedulePage extends StatelessWidget {
  final Map<String, dynamic> appointmentData; // Data janji temu yang diterima sebagai parameter

  // Konstruktor dengan parameter appointmentData
  const SchedulePage({Key? key, required this.appointmentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Janji Temu'), // Judul pada AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di sekitar body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Janji Temu:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Gaya teks untuk judul
            ),
            SizedBox(height: 20), // Jarak antara judul dan konten
            Expanded(
              child: Card(
                elevation: 5, // Elevasi untuk bayangan pada kartu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Bentuk sudut kartu melingkar
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding di dalam kartu
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dua kolom
                      mainAxisSpacing: 10.0, // Jarak antara baris
                      crossAxisSpacing: 10.0, // Jarak antara kolom
                      childAspectRatio: 3, // Rasio aspek untuk menyesuaikan konten
                    ),
                    children: [
                      // Menampilkan detail janji temu dengan ikon dan teks
                      _buildInfoTile(Icons.person, 'Dokter', appointmentData['doctorName']),
                      _buildInfoTile(Icons.person_outline, 'Nama Pasien', appointmentData['patientName']),
                      _buildInfoTile(Icons.text_fields, 'Nama Depan', appointmentData['firstName']),
                      _buildInfoTile(Icons.text_fields, 'Nama Belakang', appointmentData['lastName']),
                      _buildInfoTile(Icons.home, 'Alamat', appointmentData['address']),
                      _buildInfoTile(Icons.local_hospital, 'Klinik', appointmentData['clinic']),
                      _buildInfoTile(Icons.date_range, 'Tanggal', appointmentData['date']),
                      _buildInfoTile(Icons.access_time, 'Waktu', appointmentData['time']),
                      _buildInfoTile(Icons.calendar_today, 'Jenis Janji Temu', appointmentData['appointmentType']),
                      Align(
                        alignment: Alignment.bottomCenter, // Posisi tombol di bawah tengah
                        child: TextButton(
                          onPressed: () {
                            _cancelAppointment(appointmentData['id'], context); // Panggil fungsi pembatalan janji temu
                          },
                          child: Text(
                            'Cancel Appointment',
                            style: TextStyle(color: Colors.red), // Gaya teks tombol dengan warna merah
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi dengan ikon dan teks
  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 30), // Ikon di sisi kiri dengan warna biru
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), // Gaya teks untuk judul informasi
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12), // Gaya teks untuk subjudul informasi
      ),
    );
  }
}

// Fungsi untuk membatalkan janji temu
void _cancelAppointment(String appointmentId, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance(); // Mendapatkan instance SharedPreferences
  final storedUsername = prefs.getString('username'); // Mendapatkan username yang tersimpan
  final username = storedUsername != null && storedUsername.isNotEmpty ? storedUsername : 'anonymous'; // Jika tidak ada username, gunakan 'anonymous'

  await FirebaseFirestore.instance
      .collection('appointments')
      .doc(username)
      .collection('appointments')
      .doc(appointmentId)
      .delete(); // Menghapus dokumen janji temu dari Firestore

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Appointment cancelled successfully')), // Menampilkan snackbar setelah berhasil dibatalkan
  );

  Navigator.pop(context, true); // Navigasi kembali dengan nilai true
}
