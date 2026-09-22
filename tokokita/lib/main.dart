import 'package:flutter/material.dart';
import 'package:tokokita/models/product.dart';
import 'widgets/product_card.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'TokoKita'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> daftarProduk = [
    Product(
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: daftarProduk.length, // Menghitung otomatis total 8 produk
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          final produk = daftarProduk[index];
          return ProductCard(product: produk);
        },
      ),
    );
  }
}