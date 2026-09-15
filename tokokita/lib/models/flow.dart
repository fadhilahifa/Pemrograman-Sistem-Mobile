void main() {

  int jumlahStok = 10;
  String keteranganStok;

  if (jumlahStok > 10) {
    keteranganStok = 'Tersedia';
  } else if (jumlahStok > 0) {
    keteranganStok = 'Stok Terbatas';
  } else {
    keteranganStok = 'Habis';
  }

  print('---- 1. STATUS STOK PRODUK ----');           
  print('Nama Produk : Kemeja');
  print('Jumlah Stok : $jumlahStok');
  print('Status      : $keteranganStok');


  List<double> hargaProduk = [
    75000.0,
    93000.0,
    85000.0,
  ];

  double totalBelanja = 0;

  for (int nomor = 1;
      nomor < hargaProduk.length;
      nomor++) {
    totalBelanja += hargaProduk[nomor];
  }

  print('\n---- 2. TOTAL BELANJA ----');
  print('Jumlah Produk : ${hargaProduk.length}');
  print('Total Belanja : Rp$totalBelanja');
 

  int stokCheckout = 3;

  print('\n---- 3. SIMULASI PENGURANGAN STOK ----');
  while (stokCheckout > 0) {
    print('Produk terjual 1 -> Sisa stok: ${stokCheckout - 1}');
    stokCheckout--;
  }
  print('Status akhir   : Stok sudah habis');


  String namaKategori = 'Fashion';
  int besaranDiskon;

  switch (namaKategori) {
    case 'Elektronik':
      besaranDiskon = 10;
      break;

    case 'Fashion':
      besaranDiskon = 15;
      break;

    case 'Makanan':
      besaranDiskon = 5;
      break;

    default:
      besaranDiskon = 0;
  }

  print('\n---- 4. DISKON KATEGORI ----');
  print('Kategori : $namaKategori');
  print('Diskon   : $besaranDiskon%');

}