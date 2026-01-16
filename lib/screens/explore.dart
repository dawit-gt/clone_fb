import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  final List<String> images = const [
    'assets/images/new_pages/photo1.jpg',
    'assets/images/new_pages/photo2.jpg',
    'assets/images/new_pages/photo3.jpg',
    'assets/images/new_pages/photo4.jpg',
    'assets/images/new_pages/photo5.jpg',
    'assets/images/new_pages/photo6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
