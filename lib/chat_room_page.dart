import 'package:flutter/material.dart'; // Mengimpor package Material Flutter
import 'home_page.dart'; // Mengimpor halaman HomePage

// Deklarasi kelas ChatRoomPage sebagai StatefulWidget
class ChatRoomPage extends StatefulWidget {
  final String doctorName; // Nama dokter sebagai parameter
  final String patientName; // Nama pasien sebagai parameter

  // Konstruktor untuk ChatRoomPage
  ChatRoomPage({required this.doctorName, required this.patientName});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState(); // Membuat state untuk ChatRoomPage
}

// Deklarasi kelas _ChatRoomPageState
class _ChatRoomPageState extends State<ChatRoomPage> {
  List<Map<String, String>> messages = []; // Daftar pesan dalam bentuk map
  final TextEditingController _messageController = TextEditingController(); // Kontroler untuk input pesan

  @override
  void initState() {
    super.initState();
    _showInitialWarning(); // Menampilkan peringatan awal
  }

  // Fungsi untuk menampilkan peringatan awal
  void _showInitialWarning() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text(
                'Anda sedang berada pada chat room. Pesan akan dijawab oleh sistem bot, dan kemudian akan dijawab oleh dokter yang Anda pilih sebelumnya. Jika belum memilih dokter, silakan memilih dokter terlebih dahulu, atau pesan tidak akan dibalas oleh dokter yang menangani.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
              ),
            ],
          );
        },
      );
    });
  }

  // Fungsi untuk menambahkan pesan
  void addMessage(String message) {
    setState(() {
      messages.add({"sender": "You", "text": message}); // Menambahkan pesan pengguna
      String botResponse = getBotResponse(message); // Mendapatkan respon bot
      messages.add({"sender": widget.doctorName, "text": botResponse}); // Menambahkan respon bot
    });
    _messageController.clear(); // Membersihkan field input setelah mengirim pesan
  }

  // Fungsi untuk mendapatkan respon bot berdasarkan pesan pengguna
  String getBotResponse(String userMessage) {
    userMessage = userMessage.toLowerCase(); // Mengubah pesan pengguna menjadi huruf kecil
    if (userMessage.contains("halo")) {
      return "Selamat Datang, apa yang bisa saya bantu?";
    } else if (userMessage.contains("karang gigi")) {
      return "Karang gigi adalah plak yang mengeras dan menempel pada gigi. Membersihkan karang gigi secara rutin penting untuk kesehatan mulut. Anda bisa berkonsultasi dengan dokter terkait saat anda melakukan pemeriksaan. Semoga Informasi ini membantu :)";
    } else if (userMessage.contains("sakit gigi")) {
      return "Sakit gigi bisa disebabkan oleh berbagai hal seperti gigi berlubang, infeksi, atau masalah gusi. Saya sarankan untuk memeriksakan ke dokter gigi untuk diagnosis yang tepat.";
    } else if (userMessage.contains("konsul") || userMessage.contains("konsultasi")) {
      return "Untuk konsultasi, Anda bisa membuat janji temu dengan dokter kami melalui aplikasi ini. Apakah Anda ingin melanjutkan ke halaman janji temu atau ada pertanyaan lain?";
    } else if (userMessage.contains("tanya") || userMessage.contains("nama dokter")) {
      return "Terima kasih atas pertanyaannya. Bagaimana saya bisa membantu Anda?";
    } else if (userMessage.contains("terimakasih informasinya")) {
      return "Baik, semoga lekas sembuh";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'), // Judul pada AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Navigasi kembali ke HomePage
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length, // Jumlah pesan
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: messages[index]["sender"] == "You"
                        ? Alignment.centerRight
                        : Alignment.centerLeft, // Posisi pesan berdasarkan pengirim
                    child: Container(
                      padding: EdgeInsets.all(10), // Padding dalam container
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Margin container
                      decoration: BoxDecoration(
                        color: messages[index]["sender"] == "You" ? Colors.blue[100] : Colors.grey[300], // Warna latar berdasarkan pengirim
                        borderRadius: BorderRadius.circular(10), // Sudut melingkar
                      ),
                      child: Text(
                        messages[index]["text"]!, // Teks pesan
                        style: TextStyle(fontSize: 16), // Ukuran teks
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0), // Padding di sekitar input dan tombol
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController, // Kontroler input pesan
                    decoration: InputDecoration(
                      hintText: 'Type your message...', // Placeholder
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Border dengan sudut melingkar
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        addMessage(value); // Menambahkan pesan saat dikirim
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      addMessage(_messageController.text); // Menambahkan pesan saat tombol ditekan
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
