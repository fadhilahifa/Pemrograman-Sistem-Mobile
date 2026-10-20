import 'package:flutter/material.dart';

class CategoryTag extends StatelessWidget {
  final String category;

  const CategoryTag({Key? key, required this.category}) : super(key: key);

  // Method untuk menentukan warna berdasarkan nama kategori
Color _getTagColor(String category) {
  String lowerCategory = category.toLowerCase();
  
  // Jika mengandung unsur pakaian / fashion / perhiasan
  if (lowerCategory.contains('clothing') || lowerCategory.contains('jewelery') || lowerCategory == 'fashion') {
    return const Color.fromARGB(255, 244, 138, 173); // Warna Pink/Fashion
  } 
  // Jika mengandung unsur elektronik
  else if (lowerCategory.contains('electron') || lowerCategory == 'elektronik') {
    return const Color.fromARGB(255, 101, 179, 244); // Warna Biru/Elektronik
  } 
  // Jika makanan atau lainnya
  else if (lowerCategory.contains('food') || lowerCategory == 'makanan') {
    return const Color.fromARGB(255, 224, 76, 250); // Warna Ungu/Makanan
  }
  
  // Warna default jika kategori lain (bukan abu-abu polos lagi, tapi warna pastel yang bagus)
  return const Color.fromARGB(255, 180, 180, 180); 
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: _getTagColor(category).withOpacity(0.15),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: _getTagColor(category), width: 1.0),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: _getTagColor(category),
        ),
      ),
    );
  }
}