import 'package:flutter/material.dart';
import '../models/product.dart'; 
import 'price_label.dart';
import 'stock_badge.dart';
import 'category_tag.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isFavorite; 
  final VoidCallback onFavoriteToggle; 

  const ProductCard({
    Key? key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
    
    return Container( // Box utama
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow( // Shadow box
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
              // 1. Layer Utama: Menampilkan Gambar dari URL API
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  height: 130, 
                  width: 115,
                  color: Colors.amber[50], 
                  child: widget.product.imageUrl.startsWith('http')
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.contain, 
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.broken_image,
                              size: 42,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.shopping_bag,
                          size: 42,
                          color: Colors.grey,
                        ),
                ),
              ),
              // Badge Diskon (jika ada)
              if (isDiscounted)
                Positioned(
                  top: 6.0,    
                  right: 6.0,  
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
                      'Diskon ${(widget.product as DiscountedProduct).discountPercent.toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              // Status Stok
              Positioned(
                bottom: 6.0,
                left: 0.0,
                right: 0.0,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: StockBadge(status: widget.product.getStatusStok()),
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
                        widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: widget.isFavorite
                            ? const Color.fromARGB(255, 254, 110, 158)
                            : Colors.grey,
                      ),
                      onPressed: widget.onFavoriteToggle, 
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