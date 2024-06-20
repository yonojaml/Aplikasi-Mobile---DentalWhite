import 'package:aplikasi/schedule_page.dart'; // Mengimpor kelas SchedulePage dari jalur yang ditentukan
import 'package:flutter/material.dart'; // Mengimpor paket Material Flutter
import 'package:cloud_firestore/cloud_firestore.dart'; // Mengimpor paket Cloud Firestore
import 'package:shared_preferences/shared_preferences.dart'; // Mengimpor paket Shared Preferences

class ScheduleListPage extends StatefulWidget { // Mendefinisikan widget stateful
  const ScheduleListPage({super.key}); // Konstruktor dengan kunci

  @override
  _ScheduleListPageState createState() => _ScheduleListPageState(); // Membuat state untuk widget ini
}

class _ScheduleListPageState extends State<ScheduleListPage> { // Mendefinisikan kelas state
  late Future<List<Map<String, dynamic>>> _appointmentsFuture; // Mendeklarasikan Future untuk menyimpan janji temu

  @override
  void initState() {
    super.initState(); // Memanggil metode initState kelas induk
    _appointmentsFuture = _fetchAppointments(); // Menginisialisasi Future janji temu
  }

  @override
  Widget build(BuildContext context) { // Metode build untuk mendefinisikan UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Janji Temu'), // Judul AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di sekitar body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke awal
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _appointmentsFuture, // Future yang akan diselesaikan
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Menampilkan indikator loading saat menunggu
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No appointments found.')); // Menampilkan pesan jika tidak ada data
                  }
                  return _buildAppointmentGrid(snapshot.data!); // Membangun grid jika data tersedia
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchAppointments() async { // Metode untuk mengambil janji temu
    final prefs = await SharedPreferences.getInstance(); // Mendapatkan instance shared preferences
    final storedUsername = prefs.getString('username'); // Mendapatkan username yang disimpan
    final username = storedUsername != null && storedUsername.isNotEmpty ? storedUsername : 'anonymous'; // Menggunakan username yang disimpan atau 'anonymous'
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .doc(username)
        .collection('appointments')
        .get(); // Query Firestore untuk janji temu
    final List<Map<String, dynamic>> articles = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Mendapatkan data dokumen
      data['id'] = doc.id; // Menambahkan ID dokumen ke dalam map data
      return data;
    }).toList(); // Mengubah menjadi daftar
    return articles; // Mengembalikan daftar janji temu
  }

  Future<void> _refreshAppointments() async { // Metode untuk menyegarkan janji temu
    setState(() {
      _appointmentsFuture = _fetchAppointments(); // Memperbarui Future janji temu
    });
  }

  Widget _buildAppointmentGrid(List<Map<String, dynamic>> appointments) { // Metode untuk membangun grid
    return GridView.count(
      crossAxisCount: 2, // Jumlah kolom
      mainAxisSpacing: 10, // Jarak antara baris
      crossAxisSpacing: 10, // Jarak antara kolom
      childAspectRatio:
          (MediaQuery.of(context).size.width / 2) / 90, // Menyesuaikan rasio aspek
      children: appointments.map((appointment) {
        return _buildAppointmentCard(appointment); // Membangun kartu untuk setiap janji temu
      }).toList(),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) { // Metode untuk membangun setiap kartu
    return SizedBox(
      height: 50, // Menetapkan tinggi kartu
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bentuk kartu dengan sudut membulat
        elevation: 4, // Elevasi kartu
        color: Colors.white, // Warna kartu
        child: InkWell(
          borderRadius: BorderRadius.circular(8), // InkWell dengan sudut membulat
          onTap: () async { // Aksi saat diketuk
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SchedulePage(appointmentData: { // Navigasi ke SchedulePage
                  'doctorName': appointment['doctorName'],
                  'patientName': appointment['patientName'],
                  'appointmentType': appointment['appointmentType'],
                  'firstName': appointment['firstName'],
                  'lastName': appointment['lastName'],
                  'phoneNumber': appointment['phoneNumber'],
                  'address': appointment['address'],
                  'clinic': appointment['clinic'],
                  'date': appointment['date'],
                  'time': appointment['time'],
                  'id': appointment['id'],
                }),
              ),
            );
            if (result == true) {
              _refreshAppointments(); // Menyegarkan janji temu jika hasilnya true
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding di dalam kartu
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Menyelaraskan anak ke awal
              children: [
                Text(
                  '${appointment['doctorName']}', // Nama dokter
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2), // Jarak antara teks
                Text(
                  '${appointment['appointmentType']}', // Jenis janji temu
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
                SizedBox(height: 2), // Jarak antara teks
                Text(
                  '${appointment['date']}', // Tanggal janji temu
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
