class Product {
  // Properti Product
  String id;
  String name;
  double price;
  String imageUrl;
  String category;
  int stock;
  String? description;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
    this.description,
  });
  // Informasi produk
  String get informasiProduk {
    return 'Nama Produk : $name\n'
      'Id          : $id\n'
        'Harga       : Rp${price.toStringAsFixed(0)}\n'
        'Kategori    : $category\n'
        'Stok        : $stock\n'
        'Deskripsi   : ${description ?? 'Tidak ada deskripsi'}';
  }
  // Method untuk mengetahui status stok
  String getStatusStok() {
    if (stock > 10) {
      return 'Tersedia';
    } else if (stock > 0) {
      return 'Stok Terbatas';
    } else {
      return 'Habis';
    }
  }
}
// Class turunan DiscountedProduct
class DiscountedProduct extends Product {
  double discountPercent;

  DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });

  // Method untuk menghitung harga final
  double hitungHargaFinal() {
    double potonganHarga =
        price * discountPercent / 100;

    return price - potonganHarga;
  }
}
// Function untuk menampilkan semua data produk
void tampilkanDaftarProduk(List<Product> daftarProduk) {
  print('\n---- DATA PRODUK ----');

  for (int i = 0; i < daftarProduk.length; i++) {
    Product produk = daftarProduk[i];

    print('Produk ${i + 1} :');
    print(produk.informasiProduk);
    print('Status      : ${produk.getStatusStok()}');

    if (i < daftarProduk.length - 1) {
      print('---------------------');
    }
  }
}
// Function untuk menghitung total harga belanja
double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0;

  for (Product produk in keranjang) {
    total += produk.price;
  }

  return total;
}

void main() {
  // 1. Membuat List Product berisi 8 produk
  List<Product> daftarProduk = [
    Product(
      id: 'F001',
      name: 'Kemeja',
      price: 75000.0,
      imageUrl: 'images/kemeja.jpg',
      category: 'Fashion',
      stock: 0,
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
      price: 50000.0,
      imageUrl: 'images/piyama.jpg',
      category: 'Fashion',
      stock: 8,
      description: 'Piyama model satin yang nyaman.',
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
      price: 110000.0,
      imageUrl: 'images/ipad.jpg',
      category: 'Elektronik',
      stock: 15,
      description: 'iPad generasi terbaru dengan layar Retina warna pink.',
    ),
  ];
  // 2. Menampilkan seluruh data produk
  tampilkanDaftarProduk(daftarProduk);

  // 3. Menampilkan jumlah seluruh produk
  print('\n---- JUMLAH PRODUK ----');
  print('Jumlah produk : ${daftarProduk.length}');

  // 4. Membuat contoh keranjang belanja
  List<Product> keranjang = [
    daftarProduk[0],
    daftarProduk[1],
    daftarProduk[6],
  ];

  double totalBelanja =
      hitungTotalBelanja(keranjang);

  print('\n---- KERANJANG BELANJA ----');
  for (Product produk in keranjang) {
      print('${produk.name} : Rp${produk.price.toStringAsFixed(0)}');
  }
      print('Total Belanja : Rp${totalBelanja.toStringAsFixed(0)}',);

  // 5. Membuat instance DiscountedProduct
  DiscountedProduct kemejaDiskon =
      DiscountedProduct(
    id: 'P009',
    name: 'Kemeja',
    price: 75000.0,
    imageUrl: 'images/kemeja.jpg',
    category: 'Fashion',
    stock: 10,
    description: 'Kemeja flanel dengan harga promo.',
    discountPercent: 15,
  );

  double hargaFinal =
      kemejaDiskon.hitungHargaFinal();

  print('\n---- PRODUK DENGAN DISKON ----');
  print('Produk       : ${kemejaDiskon.name}');
  print('Harga Awal   : Rp${kemejaDiskon.price.toStringAsFixed(0)}',);
  print('Diskon       : ${kemejaDiskon.discountPercent.toStringAsFixed(0)}%',);
  print('Harga Final  : Rp${hargaFinal.toStringAsFixed(0)}',);
}