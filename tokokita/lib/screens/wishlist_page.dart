import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final ProductService productService = ProductService();
  List<Product> wishlistProducts = [];
  List<String> favoriteIds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  // 1. Memuat ID favorit dari SharedPreferences 
  Future<void> _loadWishlist() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    favoriteIds = prefs.getStringList('favorite_ids') ?? [];

    try {
      final allProducts = await productService.fetchProducts();

      if (!mounted) return;
      setState(() {
        wishlistProducts = allProducts
            .where((p) => favoriteIds.contains(p.id.toString()))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  // 2. Menghapus produk dari Wishlist dengan membaca & menulis data presisi ke SharedPreferences
  Future<void> _removeFromWishlist(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentFavorites = prefs.getStringList('favorite_ids') ?? [];
    
    currentFavorites.remove(product.id.toString());
    await prefs.setStringList('favorite_ids', currentFavorites);

    if (!mounted) return;
    setState(() {
      favoriteIds = currentFavorites;
      wishlistProducts.removeWhere((p) => p.id.toString() == product.id.toString());
    });

    Get.snackbar(
      'Berhasil',
      '${product.name} dihapus dari wishlist',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 235, 108, 150),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Saya'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            )
          : wishlistProducts.isEmpty
              ? RefreshIndicator(
                  onRefresh: _loadWishlist,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 12),
                              Text(
                                'Wishlist kamu masih kosong',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadWishlist,
                  child: ListView.builder(
                    itemCount: wishlistProducts.length,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      final produk = wishlistProducts[index];

                      return ProductCard(
                        product: produk,
                        isFavorite: true,
                        onFavoriteToggle: () => _removeFromWishlist(produk),
                      );
                    },
                  ),
                ),
    );
  }
}