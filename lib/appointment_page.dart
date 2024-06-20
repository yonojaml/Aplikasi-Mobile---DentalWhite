import 'package:aplikasi/home_page.dart'; // Import halaman beranda
import 'package:aplikasi/schedule_page.dart'; // Import halaman jadwal
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore untuk penyimpanan data
import 'package:flutter/material.dart'; // Import material design untuk antarmuka
import 'package:intl/intl.dart'; // Import intl untuk format tanggal
import 'package:shared_preferences/shared_preferences.dart'; // Import shared preferences untuk penyimpanan lokal

class AppointmentPage extends StatefulWidget { // Definisi kelas AppointmentPage
  final String doctorName; // Nama dokter
  final String patientName; // Nama pasien
  final String appointmentType; // Jenis janji temu
  final String firstName; // Nama depan pasien
  final String lastName; // Nama belakang pasien
  final String phoneNumber; // Nomor telepon pasien
  final String address; // Alamat pasien
  final String doctorPhotoUrl; // URL foto dokter

  const AppointmentPage( // Konstruktor untuk AppointmentPage
      {super.key,
      required this.doctorName,
      required this.patientName,
      required this.appointmentType,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.address,
      required this.doctorPhotoUrl});

  @override
  AppointmentPageState createState() => AppointmentPageState(); // Membuat state untuk halaman janji temu
}

class AppointmentPageState extends State<AppointmentPage> { // Definisi state untuk AppointmentPage
  final _formKey = GlobalKey<FormState>(); // Kunci form untuk validasi
  String? _selectedClinic; // Klinik yang dipilih
  DateTime? _selectedDate; // Tanggal yang dipilih
  TimeOfDay? _selectedTime; // Waktu yang dipilih

  final TextEditingController _ageController = TextEditingController(); // Controller untuk umur pasien

  final List<String> _clinics = ['RS UMUM DAERAH DR. ZAINOEL ABIDIN', 'RS UMUM DAERAH CUT MEUTIA KAB. ACEH UTARA', 'RSUP SANGLAH', 'lainnya...']; // Daftar klinik

  Future<void> _selectDate(BuildContext context) async { // Fungsi untuk memilih tanggal
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async { // Fungsi untuk memilih waktu
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveAppointment() async { // Fungsi untuk menyimpan janji temu ke Firestore
    final prefs = await SharedPreferences.getInstance(); // Mendapatkan instance shared preferences
    final storedUsername = prefs.getString('username'); // Mendapatkan username dari shared preferences
    final username = storedUsername != null && storedUsername.isNotEmpty
        ? storedUsername
        : 'anonymous'; // Jika username tidak ada, gunakan 'anonymous'

    final appointment = { // Membuat objek janji temu
      'doctorName': widget.doctorName,
      'patientName': widget.patientName,
      'appointmentType': widget.appointmentType,
      'firstName': widget.firstName,
      'lastName': widget.lastName,
      'phoneNumber': widget.phoneNumber,
      'address': widget.address,
      'clinic': _selectedClinic,
      'date': DateFormat('dd MMMM yyyy').format(_selectedDate!),
      'time': _selectedTime?.format(context),
    };

    try {
      await FirebaseFirestore.instance
          .collection('appointments') // Koleksi Firestore untuk janji temu
          .doc(username) // Dokumen untuk username tertentu
          .collection('appointments') // Koleksi janji temu untuk username
          .add(appointment); // Menambahkan janji temu
      _showSuccessDialog(context); // Menampilkan dialog sukses
    } catch (e) {
      print('Error saving appointment: $e'); // Menangani kesalahan saat menyimpan janji temu
    }
  }

  void _showSuccessDialog(BuildContext context) { // Fungsi untuk menampilkan dialog sukses
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BERHASIL!!!!'),
          content: const Text('Jangan Lupa Datang Tepat Waktu\nSee you.....'),
          actions: <Widget>[
            TextButton(
              child: const Text('Kembali ke Menu'),
              onPressed: () {
                Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()), // Navigasi ke halaman beranda
          );}
            ),
            TextButton(
              child: const Text('Lihat Jadwal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchedulePage(appointmentData: { // Navigasi ke halaman jadwal
                      'doctorName': widget.doctorName,
                      'patientName': widget.patientName,
                      'appointmentType': widget.appointmentType,
                      'firstName': widget.firstName,
                      'lastName': widget.lastName,
                      'phoneNumber': widget.phoneNumber,
                      'address': widget.address,
                      'clinic': _selectedClinic,
                      'date': _selectedDate!.toString(),
                      'time': _selectedTime!.format(context),
                    }),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) { // Fungsi untuk membangun UI
    return Scaffold(
      appBar: AppBar( // AppBar untuk halaman janji temu
        title: const Text('Detail Janji Temu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali
          },
        ),
      ),
      body: SingleChildScrollView( // Konten halaman dapat di-scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan gambar dan nama dokter
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          widget
                              .doctorPhotoUrl, // URL foto dokter
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctorName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Jenis Layanan: ${widget.appointmentType}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Form untuk detail pasien, pemilihan klinik, dan penjadwalan janji temu
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Pasien',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: widget.firstName,
                      decoration: InputDecoration(
                        labelText: 'Nama Depan',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap masukkan nama depan';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: widget.lastName,
                      decoration: InputDecoration(
                        labelText: 'Nama Belakang',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap masukkan nama belakang';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Umur',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap masukkan umur';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: widget.address,
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap masukkan alamat';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pilih Klinik',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      value: _selectedClinic,
                      items: _clinics.map((String clinic) {
                        return DropdownMenuItem<String>(
                          value: clinic,
                          child: Text(clinic),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedClinic = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Harap pilih klinik';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pilih Tanggal dan Waktu',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      title: Text(_selectedDate == null
                          ? 'Pilih Tanggal'
                          : 'Tanggal: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                    ListTile(
                      title: Text(_selectedTime == null
                          ? 'Pilih Waktu'
                          : 'Waktu: ${_selectedTime!.format(context)}'),
                      trailing: const Icon(Icons.access_time),
                      onTap: () => _selectTime(context),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) { // Validasi form
                            _formKey.currentState!.save(); // Simpan data form
                            await _saveAppointment(); // Simpan data janji temu ke Firestore
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Atur Janji Temu'), // Teks pada tombol
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
