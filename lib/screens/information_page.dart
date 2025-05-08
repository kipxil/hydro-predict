import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information Page'),
      ),
      // appBar: AppBar(
      //   title: const Text("Panduan Menggunakan Aplikasi Prediksi Usia Sawi"),
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [Colors.white, Colors.lightBlue],
      //         begin: Alignment.bottomCenter,
      //         end: Alignment.topCenter,
      //       ),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Panduan Menggunakan Aplikasi Prediksi Usia Sawi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Berikut adalah langkah-langkah untuk menggunakan aplikasi prediksi usia sawi:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Mulai aplikasi prediksi usia sawi di perangkat Anda.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Pilih menu "Prediksi" dari beranda aplikasi.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '3.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Pilih opsi "Kamera" untuk mengambil foto sawi dengan kamera, atau "Galeri" untuk memilih gambar dari galeri.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Setelah gambar diambil atau dipilih, gambar terload otomatis untuk memulai proses prediksi usia sawi.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '5.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Kemudian, gambar akan ditampilkan pada layar aplikasi.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '6.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Hasil prediksi akan ditampilkan di layar dibawah gambar hasil input, menunjukkan usia sawi dan kadar PPM-nya.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '7.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Note:  jarak pengambilan gambar melalui jarak 30 cm dari usia 1 hingga 30 hari dan jarak pengambilan gambar melalui jarak 45 cm ketika usia 31 hingga 40',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Semoga panduan ini membantu Anda dalam menggunakan aplikasi prediksi usia sawi',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}