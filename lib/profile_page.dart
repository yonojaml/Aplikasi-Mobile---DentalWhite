import 'package:flutter/foundation.dart'; // Import package untuk fitur dasar Flutter
import 'package:flutter/material.dart'; // Import package untuk widgets Material Design

class ProfilePage extends StatefulWidget { // Membuat class ProfilePage yang bersifat Stateful
  @override
  _ProfilePageState createState() => _ProfilePageState(); // Menghubungkan dengan _ProfilePageState untuk mengelola state
}

class _ProfilePageState extends State<ProfilePage> { // Membuat state dari ProfilePage
  TextEditingController _nameController = TextEditingController(text: 'Maureent'); // Controller untuk field nama
  TextEditingController _ageController = TextEditingController(text: '20 Tahun'); // Controller untuk field umur
  TextEditingController _phoneController = TextEditingController(text: '0812 3968 4020'); // Controller untuk field telepon
  TextEditingController _genderController = TextEditingController(text: 'Perempuan'); // Controller untuk field jenis kelamin
  TextEditingController _addressController = TextEditingController(text: 'Jl Dewi Sartika Barat'); // Controller untuk field alamat

  bool _isEditing = false; // Menyimpan status apakah sedang dalam mode editing atau tidak

  @override
  Widget build(BuildContext context) { // Method build untuk membuat UI
    return Scaffold( // Menggunakan Scaffold sebagai struktur utama halaman
      appBar: AppBar( // Membuat AppBar
        title: Text('Profile User'), // Judul AppBar
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
      ),
      body: SingleChildScrollView( // Membuat body yang bisa di-scroll
        child: Padding( // Padding untuk memberi ruang di sekitar child
          padding: EdgeInsets.all(16.0), // Padding dengan jarak 16.0
          child: Column( // Menggunakan Column untuk menata widgets secara vertikal
            children: [
              CircleAvatar( // Membuat avatar bulat untuk profil
                radius: 50, // Ukuran radius avatar
                backgroundImage: AssetImage('assets/profile.png'), // Gambar profil
              ),
              SizedBox(height: 20), // Memberikan jarak vertikal 20
              _buildEditableField(label: 'Name', controller: _nameController, icon: Icons.person), // Membuat field untuk nama
              _buildEditableField(label: 'Age', controller: _ageController, icon: Icons.calendar_today), // Membuat field untuk umur
              _buildEditableField(label: 'Phone', controller: _phoneController, icon: Icons.phone), // Membuat field untuk telepon
              _buildEditableField(label: 'Gender', controller: _genderController, icon: Icons.person_outline), // Membuat field untuk jenis kelamin
              _buildEditableField(label: 'Address', controller: _addressController, icon: Icons.location_on), // Membuat field untuk alamat
              SizedBox(height: 20), // Memberikan jarak vertikal 20
              ElevatedButton( // Membuat tombol ElevatedButton
              onPressed: () { // Fungsi yang dipanggil saat tombol ditekan
                _toggleEditingMode(); // Mengubah mode editing
                if (!_isEditing) { // Jika sudah selesai editing
                  _showUpdateSuccessSnackBar(); // Menampilkan SnackBar sukses
                  Navigator.pop(context, _nameController.text); // Mengirim nama yang baru ke HomePage dan kembali ke halaman sebelumnya
                }
              },
              child: Text(_isEditing ? 'Save Profile' : 'Edit Profile'), // Mengubah teks tombol sesuai dengan mode editing
              style: ElevatedButton.styleFrom( // Menentukan gaya tombol
                backgroundColor: Colors.white, // Menggunakan warna biru sebagai latar belakang
              ),
            ),
              SizedBox(height: 16), // Berikan jarak antara tombol dan bagian bawah
            ],
          ),
        ),
      ),
    );
  }

  void _toggleEditingMode() { // Fungsi untuk mengubah mode editing
    setState(() { // Mengubah state
      _isEditing = !_isEditing; // Membalik nilai _isEditing
    });
  }

  Widget _buildEditableField({required String label, required TextEditingController controller, required IconData icon}) { // Fungsi untuk membangun field yang bisa diedit
    return ListTile( // Menggunakan ListTile untuk menampilkan ikon dan teks
      leading: Icon(icon), // Ikon di sebelah kiri
      title: _isEditing // Jika sedang dalam mode editing
          ? TextFormField( // Menampilkan TextFormField untuk input
              controller: controller, // Menggunakan controller yang sesuai
              decoration: InputDecoration( // Dekorasi untuk TextFormField
                labelText: label, // Label untuk field
                labelStyle: TextStyle(color: Colors.blue), // Warna label biru
              ),
            )
          : Text( // Jika tidak dalam mode editing
              controller.text, // Menampilkan teks dari controller
              style: TextStyle(color: Colors.black ), // Warna teks biru
            ),
    );
  }

  void _showUpdateSuccessSnackBar() { // Fungsi untuk menampilkan SnackBar sukses
    final snackBar = SnackBar( // Membuat SnackBar
      content: Text('Profile Updated Successfully'), // Teks dalam SnackBar
      backgroundColor: Colors.blue, // Menggunakan warna biru sebagai latar belakang SnackBar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar); // Menampilkan SnackBar
  }
}
