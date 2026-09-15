void main() {

// Fuction dengan parameter biasa
  double hitungHargaSetelahDiskon(
    double harga,
    double persenDiskon,
  ) {
    double potonganHarga = harga * persenDiskon / 100;
    return harga - potonganHarga;
  }

  String namaProduk = 'Kemeja';
  double hargaProduk = 75000.0;
  double diskonProduk = 15.0;

  double hargaAkhir =
      hitungHargaSetelahDiskon(hargaProduk, diskonProduk);
  
  print('---- 1. HARGA SETELAH DISKON ----');
  print('Produk            : $namaProduk');
  print('Harga Awal        : Rp$hargaProduk');
  print('Diskon            : $diskonProduk%');
  print('Harga Setelah Diskon: Rp$hargaAkhir');

// Named parameter dengan default value
  double hitungHargaPromo(
    double harga, {
    double persenDiskon = 0,
  }) {
    double potonganHarga = harga * persenDiskon / 100;
    return harga - potonganHarga;
  }

  String produkLain = 'Rok Polkadot';
  double hargaProdukLain = 93000.0;

  double hargaPromo =
      hitungHargaPromo(
        hargaProdukLain,
        persenDiskon: 15,
      );

  double hargaNormal =
      hitungHargaPromo(hargaProdukLain);

  print('\n---- 2. FUNCTION DENGAN DISKON ----');
  print('Produk             : $produkLain');
  print('Harga Awal         : Rp$hargaProdukLain');
  print('Harga dengan Diskon: Rp$hargaPromo');
  print('Harga Tanpa Diskon : Rp$hargaNormal');


  String formatRupiah(double harga) =>
      'Rp${harga.toStringAsFixed(0)}';

  print('\n---- 3. ARROW FUNCTION ----');
  print('Harga $namaProduk         : ${formatRupiah(hargaProduk)}');
  print('Harga $produkLain   : ${formatRupiah(hargaProdukLain)}',);
  print('Harga Setelah Diskon : ${formatRupiah(hargaAkhir)}',);
}