import 'package:flutter/material.dart';
import '../models/product.dart'; 
import 'price_label.dart';
import 'stock_badge.dart';
import 'category_tag.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // Status lokal untuk menyimpan status favorit
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    //  initState() dipanggil
    print('LOG LIFECYCLE: initState() dipanggil pada produk ${widget.product.name}');
  }

  @override
  void dispose() {
    //  dispose() dipanggil
    print('LOG LIFECYCLE: dispose() dipanggil pada produk ${widget.product.name}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  build() dipanggil (termasuk saat setState dipanggil)
    print('LOG LIFECYCLE: build() dipanggil pada produk ${widget.product.name}');

    return Card(
      clipBehavior: Clip.antiAlias, // untuk memotong konten yang melampaui batas Card
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Placeholder Gambar Produk
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.amber[100],
            child: const Icon(
              Icons.shopping_bag,
              size: 60,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Nama Produk
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Tombol Favorit (IconButton)
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? const Color.fromARGB(255, 254, 110, 158) : Colors.grey,
                      ),
                      onPressed: () {
                        // Memanggil setState() untuk merubah state lokal isFavorite
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        print(
                          'LOG EVENT: Tombol favorit ditekan! Status isFavorite: $isFavorite',
                        );
                      },
                    ),
                  ],
                ),
                // Kategori Produk
                CategoryTag(category: widget.product.category),
                const SizedBox(height: 2),
                // Harga Produk
                PriceLabel(price: widget.product.price),
                const SizedBox(height: 4),
                // Status Stok
                StockBadge(status: widget.product.getStatusStok()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}