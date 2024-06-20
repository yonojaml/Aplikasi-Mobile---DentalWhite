import 'package:aplikasi/chat_room_page.dart' as chatRoom; // Mengimpor halaman chat room dengan alias
import 'package:flutter/material.dart'; // Mengimpor package Material dari Flutter
import 'appointment_page.dart'; // Mengimpor halaman appointment

class DoctorDetailPage extends StatefulWidget { // Membuat class DoctorDetailPage yang merupakan StatefulWidget
  final String name; // Deklarasi variabel name
  final String imageUrl; // Deklarasi variabel imageUrl
  final String address; // Deklarasi variabel address
  final String description; // Deklarasi variabel description

  DoctorDetailPage({ // Konstruktor untuk menerima parameter
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.description,
  });

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState(); // Membuat state untuk DoctorDetailPage
}

class _DoctorDetailPageState extends State<DoctorDetailPage> { // Membuat state class
  String _selectedService = 'Atur Janji Temu'; // Variabel untuk menyimpan layanan yang dipilih
  final TextEditingController _firstNameController = TextEditingController(); // Controller untuk input nama depan
  final TextEditingController _lastNameController = TextEditingController(); // Controller untuk input nama belakang
  final TextEditingController _addressController = TextEditingController(); // Controller untuk input alamat
  final TextEditingController _phoneNumberController = TextEditingController(); // Controller untuk input nomor telepon

  @override
  void dispose() { // Method dispose untuk membersihkan controller
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { // Method build untuk membuat UI
    return Scaffold( // Menggunakan Scaffold sebagai struktur utama halaman
      appBar: AppBar( // Membuat AppBar
        title: Text('Tentang Dokter'), // Judul AppBar
      ),
      body: SingleChildScrollView( // Membuat body yang bisa di-scroll
        child: Padding( // Padding untuk memberi ruang di sekitar child
          padding: const EdgeInsets.all(16.0), // Padding dengan jarak 16.0
          child: Column( // Menggunakan Column untuk menata widgets secara vertikal
            crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment widget di dalam Column
            children: [
              Card( // Menggunakan Card untuk menampung informasi dokter
                shape: RoundedRectangleBorder( // Mengatur bentuk border card
                  borderRadius: BorderRadius.circular(15), // Border radius 15
                ),
                elevation: 4, // Mengatur elevasi card
                child: Padding( // Padding di dalam Card
                  padding: const EdgeInsets.all(16.0), // Padding dengan jarak 16.0
                  child: Row( // Menggunakan Row untuk menata widget secara horizontal
                    children: [
                      ClipRRect( // Menggunakan ClipRRect untuk memberikan border radius pada gambar
                        borderRadius: BorderRadius.circular(10), // Border radius 10
                        child: Image.asset( // Menampilkan gambar dari asset
                          widget.imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10), // Memberikan jarak horizontal 10
                      Expanded( // Membuat widget child bisa expand
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5), // Memberikan jarak vertikal 5
                            Text(
                              widget.address,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Memberikan jarak vertikal 20
              Padding( // Padding untuk memberi ruang di sekitar child
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding horizontal dengan jarak 16.0
                child: Column( // Menggunakan Column untuk menata widgets secara vertikal
                  crossAxisAlignment: CrossAxisAlignment.start, // Mengatur alignment widget di dalam Column
                  children: [
                    Text(
                      'Data Pasien',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10), // Memberikan jarak vertikal 10
                    TextFormField( // Input field untuk nama depan
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Depan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 10), // Memberikan jarak vertikal 10
                    TextFormField( // Input field untuk nama belakang
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Belakang',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 10), // Memberikan jarak vertikal 10
                    TextFormField( // Input field untuk alamat
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 20), // Memberikan jarak vertikal 20
                    Text(
                      'Pilihan Layanan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile( // Pilihan layanan "Atur Janji Temu"
                      title: Text('Atur Janji Temu'),
                      value: 'Atur Janji Temu',
                      groupValue: _selectedService,
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value.toString();
                        });
                      },
                    ),
                    RadioListTile( // Pilihan layanan "Konsultasi Online"
                      title: Text('Konsultasi Online'),
                      value: 'Konsultasi Online',
                      groupValue: _selectedService,
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Memberikan jarak vertikal 20
              ElevatedButton( // Membuat tombol ElevatedButton
                onPressed: () {
                  if (_selectedService == 'Atur Janji Temu') { // Jika layanan yang dipilih adalah "Atur Janji Temu"
                    Navigator.push( // Navigasi ke halaman appointment
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentPage(
                          doctorName: widget.name,
                          patientName: '${_firstNameController.text} ${_lastNameController.text}',
                          appointmentType: _selectedService, 
                          firstName: _firstNameController.text, 
                          lastName: _lastNameController.text,
                          phoneNumber: _phoneNumberController.text, 
                          address: _addressController.text,
                          doctorPhotoUrl: widget.imageUrl,
                        ),
                      ),
                    );
                  } else if (_selectedService == 'Konsultasi Online') { // Jika layanan yang dipilih adalah "Konsultasi Online"
                    Navigator.push( // Navigasi ke halaman chat room
                      context,
                      MaterialPageRoute(
                        builder: (context) => chatRoom.ChatRoomPage(
                          doctorName: widget.name,
                          patientName: '${_firstNameController.text} ${_lastNameController.text}',
                        ),
                      ),
                    );
                  }
                },
                child: Text('Lanjutkan'), // Teks tombol
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Padding tombol
                  textStyle: TextStyle(fontSize: 16), // Ukuran teks tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
