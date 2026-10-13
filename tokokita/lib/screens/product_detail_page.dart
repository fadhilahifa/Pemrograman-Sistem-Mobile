import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../widgets/category_tag.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

    ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // State untuk menyimpan jumlah item yang dipilih sebelum masuk keranjang
  final CartController cartController = Get.find();
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    // Mengecek apakah produk merupakan objek turunan DiscountedProduct
    final isDiscounted = product is DiscountedProduct;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Produk dengan Stack untuk Badge Diskon
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Stack(
                  children: [
                    // Gambar Utama
                    Container(
                      height: 220,
                      width: double.infinity,
                      color: Colors.amber[100],
                      child: const Icon(
                        Icons.shopping_bag,
                        size: 90,
                        color: Colors.grey,
                      ),
                    ),
                    // Badge Diskon (Pojok Kanan Atas Gambar)
                    if (isDiscounted)
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 97, 87),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            'Diskon ${(product as DiscountedProduct).discountPercent.toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. Category Tag
            CategoryTag(category: product.category),
            const SizedBox(height: 8),

            // 3. Nama Produk
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // 4. Harga Produk
            Text(
              'Rp ${product.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),

            // 5. Status Stok
            Row(
              children: [
                const Text(
                  'Status Stok: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.stock > 0
                      ? 'Tersedia (${product.stock})'
                      : 'Stok Habis',
                  style: TextStyle(
                    color: product.stock > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            // 6. Deskripsi Produk
            const Text(
              'Deskripsi Produk',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description ?? 'Belum ada deskripsi untuk produk ini.',
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            // 7. Tambah/Kurang Jumlah Pembelian (Asli Sesuai Kode Kamu)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Tombol Kurang (-)
                      IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: (product.stock > 0 && _quantity > 1)
                            ? () {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            : null,
                      ),
                      // Angka Jumlah Item
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: .0),
                        child: Text(
                          product.stock > 0 ? '$_quantity' : '0',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: product.stock > 0 ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                      // Tombol Tambah (+)
                      IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: (product.stock > 0 && _quantity < product.stock)
                            ? () {
                                setState(() {
                                  _quantity++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 8. Tombol Tambah ke Keranjang
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: product.stock > 0 ? Colors.blueAccent : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(
                  product.stock > 0 ? Icons.shopping_cart_sharp : Icons.block,
                  color: Colors.white,
                ),
                label: Text(
                  product.stock > 0
                      ? 'Tambah ke Keranjang ($_quantity)'
                      : 'Stok Habis',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                // Setelah menambahkan produk ke keranjang, maka akan kembali ke halaman sebelumnya (Get.back()) dan menampilkan snackbar
                onPressed: product.stock > 0
                    ? () {
                      Get.back(); 
                      cartController.addToCart(product, quantity: _quantity);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}