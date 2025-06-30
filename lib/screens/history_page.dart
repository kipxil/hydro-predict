// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../widgets/history_widget.dart';
import '../services/api_client.dart';
import '../services/api_config.dart';

final _apiClient = ApiClient();

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  List<HistoryModel> historyList = [];
  String? errorMessage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    setState(() {
      isLoading = true; // Tampilkan loading saat request
      errorMessage = null;
    });

    try {
      var response = await _apiClient.get("/history");

      if (response.data is Map<String, dynamic> &&
          response.data.containsKey("error")) {
        throw Exception(response.data["error"]);
      }

      List<dynamic> data = response.data;
      setState(() {
        historyList = data.map((item) => HistoryModel.fromJson(item)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Gagal mengambil history";
        isLoading = false;
      });
    }
  }

  void deleteHistory(int id) async {
    try {
      var response = await _apiClient.delete("/delete_history/$id");

      if (response.statusCode == 200) {
        setState(() {
          historyList.removeWhere((item) => item.id == id);
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Berhasil"),
            content: const Text("History berhasil dihapus"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.all(20),
          child: Text("Gagal menghapus: ${e.toString()}"),
        ),
      );
    }
  }

  void confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus History"),
          content: const Text("Apakah Anda yakin ingin menghapus history ini?"),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Hapus", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                deleteHistory(id);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteAllHistory() async {
    try {
      var response = await _apiClient.delete("/delete_all_history");

      if (response.statusCode == 200) {
        setState(() {
          historyList.clear();
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Berhasil"),
            content: const Text("Semua history berhasil dihapus"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Gagal"),
          content: const Text("Gagal menghapus semua history"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void confirmDeleteAll() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Semua History"),
          content:
              const Text("Apakah Anda yakin ingin menghapus semua history?"),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Hapus Semua",
                  style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                deleteAllHistory();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
              onPressed: () => confirmDeleteAll(),
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              tooltip: "Hapus Semua History")
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      Text(errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: fetchHistory,
                        child: const Text("Coba Lagi"),
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchHistory,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          historyList.isEmpty
                              ? const SizedBox(
                                  height:
                                      500, // Tinggi minimum untuk empty state
                                  child: Center(
                                    child: Text("Tidak ada history tersimpan.",
                                        style: TextStyle(fontSize: 16)),
                                  ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: historyList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(8),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            "${ApiConfig.baseUrl}/static/simpan_gambar2/${historyList[index].imagePath}",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: 80,
                                                height: 80,
                                                color: Colors.grey.shade200,
                                                child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey),
                                              );
                                            },
                                          ),
                                        ),
                                        title: Text(
                                            "Prediksi: ${historyList[index].prediction}"),
                                        subtitle: Text(
                                            "Waktu: ${historyList[index].timestamp}"),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () => confirmDelete(
                                              historyList[index].id),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
