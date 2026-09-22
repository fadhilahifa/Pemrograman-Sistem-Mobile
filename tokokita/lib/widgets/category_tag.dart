import 'package:flutter/material.dart';

class CategoryTag extends StatelessWidget {
  final String category;

  const CategoryTag({Key? key, required this.category}) : super(key: key);

  // Method untuk menentukan warna berdasarkan nama kategori
  Color _getTagColor() {
    switch (category.toLowerCase()) {
      case 'fashion':
        return const Color.fromARGB(255, 244, 138, 173);
      case 'elektronik':
        return const Color.fromARGB(255, 101, 179, 244);
      case 'makanan':
        return const Color.fromARGB(255, 224, 76, 250);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _getTagColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: _getTagColor(), width: 1.0),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: _getTagColor(),
        ),
      ),
    );
  }
}