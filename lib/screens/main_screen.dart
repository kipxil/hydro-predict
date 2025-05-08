import 'package:flutter/material.dart';
import 'home_page.dart';
import 'gallery_page.dart';
import 'prediction_page.dart';
import 'history_page.dart';
import 'information_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Menyimpan halaman-halaman yang sesuai dengan tab
  final List<Widget> _pages = [
    const HomePage(),      // Home Page
    const GalleryPage(),   // Gallery Page
    const PredictionPage(), // Prediction Page
    const HistoryPage(),   // History Page
    const InformationPage(), // Information Page
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan halaman yang sesuai
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2; // Prediction tab
          });
        },
        backgroundColor: Colors.white,
        elevation: 6,
        child: Image.asset('assets/images/predic.png', width: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green[700],
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed, // Untuk 5 item tab
        items: const [
          BottomNavigationBarItem(
            // icon: Image.asset('assets/images/home.png', width: 25),
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: "Gallery",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: "Prediction",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Information",
          ),
        ],
      ),
    );
  }
}
