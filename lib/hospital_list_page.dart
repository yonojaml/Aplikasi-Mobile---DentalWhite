import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Mendefinisikan kelas Rumah Sakit dengan properti yang relevan
class Hospital {
  final String name;
  final String address;
  final String phone;
  final String province;

  // Konstruktor untuk menginisialisasi properti
  Hospital({
    required this.name,
    required this.address,
    required this.phone,
    required this.province,
  });

  // Konstruktor pabrik untuk membuat instance Rumah Sakit dari data JSON
  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      province: json['province'] ?? '',
    );
  }
}

// Mendefinisikan widget stateful untuk halaman daftar rumah sakit
class HospitalListPage extends StatefulWidget {
  @override
  _HospitalListPageState createState() => _HospitalListPageState();
}

// Kelas state untuk HospitalListPage
class _HospitalListPageState extends State<HospitalListPage> {
  late Future<List<Hospital>> futureHospitals; // Future untuk menampung daftar rumah sakit

  @override
  void initState() {
    super.initState();
    futureHospitals = fetchHospitals(); // Mengambil data rumah sakit saat widget diinisialisasi
  }

  // Fungsi untuk mengambil data rumah sakit dari API
  Future<List<Hospital>> fetchHospitals() async {
    final response = await http.get(Uri.parse('https://dekontaminasi.com/api/id/covid19/hospitals'));

    if (response.statusCode == 200) { // Memeriksa apakah respons berhasil
      List<dynamic> data = json.decode(response.body); // Mendekode data JSON
      return data.map((json) => Hospital.fromJson(json)).toList(); // Mengubah data JSON menjadi daftar objek Rumah Sakit
    } else {
      throw Exception('Gagal memuat rumah sakit'); // Melempar pengecualian jika respons tidak berhasil
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Rumah Sakit',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data Rumah Sakit'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigasi kembali saat tombol kembali ditekan
            },
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Hospital>>(
            future: futureHospitals,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Menampilkan indikator pemuatan saat menunggu data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Menampilkan pesan kesalahan jika ada error
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length, // Menentukan jumlah item dalam daftar
                  itemBuilder: (context, index) {
                    return Card(
                      color: index.isEven ? Colors.blue[100] : Colors.white, // Mengganti warna latar belakang secara bergantian
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Menambahkan margin di sekitar kartu
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), // Nama rumah sakit dengan font tebal
                            ),
                            SizedBox(height: 8.0),
                            Text('Alamat: ${snapshot.data![index].address}'), // Menampilkan alamat rumah sakit
                            SizedBox(height: 4.0),
                            Text('Provinsi: ${snapshot.data![index].province}'), // Menampilkan provinsi rumah sakit
                            SizedBox(height: 4.0),
                            Text('Telepon: ${snapshot.data![index].phone}'), // Menampilkan nomor telepon rumah sakit
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Text('Tidak ada data yang tersedia'); // Menampilkan pesan jika tidak ada data
              }
            },
          ),
        ),
      ),
    );
  }
}
