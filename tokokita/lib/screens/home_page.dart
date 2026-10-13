import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';
import '../screens/product_detail_page.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class HomePage extends StatelessWidget {

  final CartController cartController = Get.find();
   HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Aplikasi (Langkah 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Judul dan Subjudul menggunakan Column
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TokoKita',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Belanja jadi lebih mudah',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  // Tombol login di pojok kanan atas
                  IconButton(
                    icon: const Icon(Icons.login, size: 28),
                    tooltip: 'Login',
                    onPressed: () {
                      // Navigasi ke halaman login
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Daftar Produk (Langkah 2)
              Expanded(
                child: ListView.builder(
                  itemCount: daftarProduk.length, // Import dari product.dart
                  padding: const EdgeInsets.only(bottom: 16.0),
                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];

                    return InkWell(
                      onTap: () async {
                        await Get.to(
                          () => ProductDetailPage(product: produk),
                          );
                      },
                      child: ProductCard(product: produk),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}