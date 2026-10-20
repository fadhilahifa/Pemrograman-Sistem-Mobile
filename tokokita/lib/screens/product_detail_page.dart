import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../widgets/category_tag.dart';
import '../services/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final CartController cartController = Get.find();
  
  final ProductService productService = ProductService();
  late Future<Product> futureProductDetail;

  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    int productId = int.tryParse(widget.product.id) ?? 1;
    futureProductDetail = productService.fetchProductDetail(productId);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<Product>(
        future: futureProductDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal memuat detail produk:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('Data produk tidak ditemukan.'),
            );
          }

          final product = snapshot.data!;
          final isDiscounted = product is DiscountedProduct;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Gambar Produk dengan Container Rapi & Pas
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      children: [
                        // Container dengan background putih & border tipis agar foto terbingkai rapi
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0), // Padding agar gambar tidak menempel garis tepi
                            child: product.imageUrl.startsWith('http')
                                ? Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.contain, // Memastikan seluruh gambar utuh & tidak terpotong
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image, size: 90, color: Colors.grey),
                                  )
                                : const Icon(
                                    Icons.shopping_bag,
                                    size: 90,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        // Badge Diskon (jika produk diskon)
                        if (isDiscounted)
                          Positioned(
                            top: 12.0,
                            right: 12.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 240, 97, 87),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                'Diskon ${(product as DiscountedProduct).discountPercent.toInt()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0,
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
                  'Rp ${product.price.toStringAsFixed(0)}',
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

                // 7. Tambah/Kurang Jumlah Pembelian
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.stock > 0 ? '$_quantity' : '0',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: product.stock > 0 ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
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
          );
        },
      ),
    );
  }
}