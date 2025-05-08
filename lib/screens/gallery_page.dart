import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {
  final List<Map<String, String>> images = [
    {
      'image': 'assets/images/8 Day.jpg',
      'description': 'Tanaman Sawi Usia 8 Hari',
    },
    {
      'image': 'assets/images/9 Day.jpg',
      'description': 'Tanaman Sawi Usia 9 Hari',
    },
    {
      'image': 'assets/images/10 Day.jpg',
      'description': 'Tanaman Sawi Usia 10 Hari',
    },
    {
      'image': 'assets/images/11 Day.jpg',
      'description': 'Tanaman Sawi Usia 11 Hari',
    },
    {
      'image': 'assets/images/12 Day.jpg',
      'description': 'Tanaman Sawi Usia 12 Hari',
    },
    {
      'image': 'assets/images/13 Day.jpg',
      'description': 'Tanaman Sawi Usia 13 Hari',
    },
    {
      'image': 'assets/images/14 Day.jpg',
      'description': 'Tanaman Sawi Usia 14 Hari',
    },
    {
      'image': 'assets/images/15 Day.jpg',
      'description': 'Tanaman Sawi Usia 15 Hari',
    },
    {
      'image': 'assets/images/16 Day.jpg',
      'description': 'Tanaman Sawi Usia 16 Hari',
    },
    {
      'image': 'assets/images/17 Day.jpg',
      'description': 'Tanaman Sawi Usia 17 Hari',
    },
    {
      'image': 'assets/images/18 Day.jpg',
      'description': 'Tanaman Sawi Usia 18 Hari',
    },
    {
      'image': 'assets/images/19 Day.jpg',
      'description': 'Tanaman Sawi Usia 19 Hari',
    },
    {
      'image': 'assets/images/20 Day.jpg',
      'description': 'Tanaman Sawi Usia 20 Hari',
    },
    {
      'image': 'assets/images/21 Day.jpg',
      'description': 'Tanaman Sawi Usia 21 Hari',
    },
    {
      'image': 'assets/images/22 Day.jpg',
      'description': 'Tanaman Sawi Usia 22 Hari',
    },
    {
      'image': 'assets/images/23 Day.jpg',
      'description': 'Tanaman Sawi Usia 23 Hari',
    },
    {
      'image': 'assets/images/24 Day.jpg',
      'description': 'Tanaman Sawi Usia 24 Hari',
    },
    {
      'image': 'assets/images/25 Day.jpg',
      'description': 'Tanaman Sawi Usia 25 Hari',
    },
    {
      'image': 'assets/images/26 Day.jpg',
      'description': 'Tanaman Sawi Usia 26 Hari',
    },
    {
      'image': 'assets/images/27 Day.jpg',
      'description': 'Tanaman Sawi Usia 27 Hari',
    },
    {
      'image': 'assets/images/28 Day.jpg',
      'description': 'Tanaman Sawi Usia 28 Hari',
    },
    {
      'image': 'assets/images/29 Day.jpg',
      'description': 'Tanaman Sawi Usia 29 Hari',
    },
    {
      'image': 'assets/images/30 Day.jpg',
      'description': 'Tanaman Sawi Usia 30 Hari',
    },
    {
      'image': 'assets/images/31 Day.jpg',
      'description': 'Tanaman Sawi Usia 31 Hari',
    },
    {
      'image': 'assets/images/32 Day.jpg',
      'description': 'Tanaman Sawi Usia 32 Hari',
    },
  ];

  void _showImagePopup(BuildContext context, String imagePath, String description) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5), // transparan latar belakang
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  ),
                  child: Text(
                    description,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          crossAxisCount: 2, // 2 kolom
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showImagePopup(
                  context,
                  images[index]['image']!,
                  images[index]['description']!
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  images[index]['image']!,
                  fit: BoxFit.cover,
                ),
              )
            );
          },
        ),
      ),
    );
  }
}