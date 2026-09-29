import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../models/product.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final List<Product> daftarProduk = [
    DiscountedProduct(
      id: 'F001',
      name: 'Kemeja',
      price: 75000.0,
      imageUrl: 'images/kemeja.jpg',
      category: 'Fashion',
      stock: 20,
      description: 'Kemeja flanel dengan motif kotak.',
    ),
    Product(
      id: 'F002',
      name: 'Rok Polkadot',
      price: 93000.0,
      imageUrl: 'images/rok_polkadot.jpg',
      category: 'Fashion',
      stock: 25,
      description: 'Rok dengan motif polkadot.',
    ),
    Product(
      id: 'F003',
      name: 'Piyama',
      price: 350000.0,
      imageUrl: 'images/piyama.jpg',
      category: 'Fashion',
      stock: 8,
      description: 'Piyama model satin yang nyaman..',
    ),
    Product(
      id: 'M001',
      name: 'Nutella',
      price: 460000.0,
      imageUrl: 'images/nutella.jpg',
      category: 'Makanan',
      stock: 8,
      description: 'Nutella selai cokelat kacang.',
    ),
    Product(
     id: 'M002',
      name: 'Dubai Chewy Cookie',
      price: 150000.0,
      imageUrl: 'images/dubai_chewy.jpg',
      category: 'Makanan',
      stock: 12,
      description: 'Dubai chewy dengan pistachio paste di dalamnya.',
    ),
    Product(
      id: 'M003',
      name: 'Mineral Water',
      price: 5000.0,
      imageUrl: 'images/water.jpg',
      category: 'Makanan',
      stock: 23,
      description: 'Air putih asli pegunungan.',
    ),
    Product(
      id: 'E001',
      name: 'Rexus Mouse',
      price: 175000.0,
      imageUrl: 'images/mouse.jpg',
      category: 'Elektronik',
      stock: 7,
      description: 'Mouse gaming dengan sensor optik.',
    ),
    Product(
      id: 'E002',
      name: 'iPad Gen 11',
      price: 6000000.0,
      imageUrl: 'images/ipad.jpg',
      category: 'Elektronik',
      stock: 0,
      description: 'iPad generasi terbaru dengan layar Retina warna pink.',
    ),
    DiscountedProduct(
      id: 'F004',
      name: 'Jaket Denim',
      price: 250000.0,
      imageUrl: 'images/jaket.jpg',
      category: 'Fashion',
      stock: 15,
      description: 'Jaket denim gaya kasual.',
    ),
    Product(
      id: 'E003',
      name: 'Kipas Laptop',
      price: 450000.0,
      imageUrl: 'images/kipas.jpg',
      category: 'Elektronik',
      stock: 5,
      description: 'Kipas pendingin laptop dengan desain kedap suara.',
    ),
    DiscountedProduct(
      id: 'M004',
      name: 'Keripik Kentang',
      price: 18000.0,
      imageUrl: 'images/keripik.jpg',
      category: 'Makanan',
      stock: 50,
      description: 'Camilan renyah rasa keju.',
    ),
    Product(
      id: 'F005',
      name: 'Jaket UV',
      price: 45000.0,
      imageUrl: 'images/jaket.jpg',
      category: 'Fashion',
      stock: 30,
      description: 'Jaket UV cocok untuk olahraga.',
    ),
    DiscountedProduct(
      id: 'E004',
      name: 'Headphone Bluetooth',
      price: 320000.0,
      imageUrl: 'images/headphone.jpg',
      category: 'Elektronik',
      stock: 9,
      description: 'Suara bass jernih tanpa kabel.',
    ),
    Product(
      id: 'M005',
      name: 'Cokelat Silverqueen',
      price: 25000.0,
      imageUrl: 'images/cokelat.jpg',
      category: 'Makanan',
      stock: 5,
      description: 'Cokelat hitam premium.',
    ),
    DiscountedProduct(
      id: 'F006',
      name: 'Topi Baseball',
      price: 60000.0,
      imageUrl: 'images/topi.jpg',
      category: 'Fashion',
      stock: 14,
      description: 'Topi bergaya sporty.',
    ),
    Product(
      id: 'E005',
      name: 'Powerbank 10000mAh',
      price: 190000.0,
      imageUrl: 'images/powerbank.jpg',
      category: 'Elektronik',
      stock: 11,
      description: 'Pengisian daya cepat fast charging.',
    ),
    DiscountedProduct(
      id: 'M006',
      name: 'Roti Tawar',
      price: 15000.0,
      imageUrl: 'images/roti.jpg',
      category: 'Makanan',
      stock: 20,
      description: 'Roti lembut untuk sarapan.',
    ),
    Product(
      id: 'F007',
      name: 'Croptop Coquette',
      price: 180000.0,
      imageUrl: 'images/croptop.jpg',
      category: 'Fashion',
      stock: 16,
      description: 'Croptop dengan desain desain unik.',
    ),
    DiscountedProduct(
      id: 'E006',
      name: 'Smartwatch',
      price: 7500000.0,
      imageUrl: 'images/smartwatch.jpg',
      category: 'Elektronik',
      stock: 4,
      description: 'Pelacak kebugaran dan detak jantung.',
    ),
    Product(
      id: 'M007',
      name: 'Kopi Susu Biji',
      price: 30000.0,
      imageUrl: 'images/kopi.jpg',
      category: 'Makanan',
      stock: 22,
      description: 'Biji kopi arabika segar.',
    ),
  ];
  

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
                  // Ikon Keranjang Belanja
                  IconButton(
                    onPressed: () {
                      // Aksi keranjang
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Daftar Produk (Langkah 2)
              Expanded(
                child: ListView.builder(
                  itemCount: daftarProduk.length,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  itemBuilder: (context, index) {
                    final produk = daftarProduk[index];
                    return ProductCard(product: produk);
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