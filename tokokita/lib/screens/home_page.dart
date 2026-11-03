import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import '../widgets/product_card.dart';
import '../models/product.dart';
import '../screens/product_detail_page.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../services/product_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartController cartController = Get.find();
  final ProductService productService = ProductService();
  
  late Future<List<Product>> futureProducts;

  // List untuk menyimpan ID produk yang difavoritkan
  List<String> favoriteIds = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites(); 
    loadProducts();
  }

  // Memuat daftar ID favorit dari SharedPreferences dengan pengaman mounted
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    });
  }

  //  Membaca data terbaru dari SharedPreferences 
  Future<void> _toggleFavorite(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    
    List<String> currentFavorites = prefs.getStringList('favorite_ids') ?? [];

    if (currentFavorites.contains(productId)) {
      currentFavorites.remove(productId);
    } else {
      currentFavorites.add(productId);
    }

    // Simpan list terbaru yang valid ke disk
    await prefs.setStringList('favorite_ids', currentFavorites);

    if (!mounted) return;
    setState(() {
      favoriteIds = currentFavorites;
    });
  }

  // Fungsi untuk memuat ulang data produk
  void loadProducts() {
    setState(() {
      futureProducts = productService.fetchProducts();
    });
  }

  Future<void> _refreshData() async {
    await _loadFavorites(); 
    setState(() {
      futureProducts = productService.fetchProducts();
    });
    await futureProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Aplikasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        'Semua ada di TokoKita!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Muat Ulang',
                        onPressed: () {
                          _refreshData();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.login, size: 28),
                        tooltip: 'Login',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: FutureBuilder<List<Product>>(
                    future: futureProducts,
                    builder: (context, snapshot) {
                      // Kondisi 1: Loading
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        );
                      }

                      // Kondisi 2: Terjadi Error
                      else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, size: 48, color: Colors.red),
                              const SizedBox(height: 12),
                              const Text(
                                'Gagal memuat produk, coba lagi',
                                style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '(${snapshot.error})',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: loadProducts,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Coba Lagi'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[100],
                                  foregroundColor: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        );
                      } 
                      // Kondisi 3: Data Kosong
                      else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada produk tersedia.'),
                        );
                      }

                      // Kondisi 4: Berhasil
                      final daftarProdukApi = snapshot.data!;

                      return ListView.builder(
                        itemCount: daftarProdukApi.length,
                        padding: const EdgeInsets.only(bottom: 16.0),
                        itemBuilder: (context, index) {
                          final produk = daftarProdukApi[index];

                          // Cek apakah ID produk ada di dalam list favoriteIds
                          final isFav = favoriteIds.contains(produk.id.toString());

                          return InkWell(
                            onTap: () async {
                              await Get.to(
                                () => ProductDetailPage(product: produk),
                              );
                              // Refresh favorit jika kembali dari detail page
                              _loadFavorites();
                            },
                            child: ProductCard(
                              product: produk,
                              isFavorite: isFav, 
                              onFavoriteToggle: () => _toggleFavorite(produk.id.toString()), // Oper callback toggle
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}