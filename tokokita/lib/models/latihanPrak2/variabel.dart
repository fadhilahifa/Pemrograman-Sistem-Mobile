void main() {
  const String namaToko = 'TokoKita';

  int stok = 10;
  double harga = 75000.0;
  String namaProduk = 'Kemeja';
  bool statusTersedia = true;

  var namaPelanggan = 'Ifa';
  final hargaProduk = 75000;

  print('---- INFO PRODUK ------ ');
  print('Toko          : $namaToko');
  print('Produk        : $namaProduk');
  print('Nama Pelanggan: $namaPelanggan');
  print('Harga         : Rp$harga');
  print('Stok          : $stok');
  print('Tersedia      : $statusTersedia');
  print('Harga Produk  : Rp$hargaProduk');

  List<String> prdukKategori = [
    'Elektronik',
    'Fashion',
    'Makanan',
  ];

  Map<String, dynamic> produkMentah = {
    'id': 'F002',
    'name': 'Rok Polkadot',
    'price': 93000,
    'stock': 25,
    'available': true,
    'category': 'Fashion',
  };

  print('\n----- DAFTAR KATEGORI -----');
  print('1. ${prdukKategori[0]}');
  print('2. ${prdukKategori[1]}');
  print('3. ${prdukKategori[2]}');

  print('\n----- DATA PRODUK MENTAH -----');
  print('ID        : ${produkMentah['id']}');
  print('Nama      : ${produkMentah['name']}');
  print('Harga     : Rp${produkMentah['price']}');
  print('Stok      : ${produkMentah['stock']}');
  print('Tersedia  : ${produkMentah['available']}');
  print('Kategori  : ${produkMentah['category']}');
}