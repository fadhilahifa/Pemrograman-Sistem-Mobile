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
    print('LOG LIFECYCLE: initState() dipanggil pada produk ${widget.product.name}');
  }

  @override
  void dispose() {
    print('LOG LIFECYCLE: dispose() dipanggil pada produk ${widget.product.name}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('LOG LIFECYCLE: build() dipanggil pada produk ${widget.product.name}');
    final isDiscounted = widget.product is DiscountedProduct;
    return Container( // box nya
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow( // shadow box
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Layer Utama: Placeholder Gambar Produk
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  height: 130, 
                  width: 115,
                  color: Colors.amber[100],
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 42,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (isDiscounted)
                Positioned(
                  top: 6.0,    // Jarak dari atas gambar
                  right: 6.0,  // Jarak dari kanan gambar
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 97, 87), // Warna badge diskon
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'Diskon ${(widget.product as DiscountedProduct).discountPercent.toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6.0, // Jarak dari bawah gambar
                  left: 0.0,
                  right: 0.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: StockBadge(status: widget.product.getStatusStok())
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12.0),

          // Detail Produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? const Color.fromARGB(255, 254, 110, 158)
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                CategoryTag(category: widget.product.category),
                const SizedBox(height: 4.0),
                PriceLabel(price: widget.product.price),
              ],
            ),
          ),
        ],
      ),
    );
  }
}