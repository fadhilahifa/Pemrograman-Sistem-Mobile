void main() {
  double hargaKemeja = 75000.0;
  double hargaRokPolkadot = 93000.0;
  int stokKemeja = 10;
  int stokRokPolkadot = 25;
  int jumlahBeli = 3;

  print('--- 1. Operator Aritmatika ---');

  double totalHargaKemeja = hargaKemeja * jumlahBeli;
  int sisaStokKemeja = stokKemeja - jumlahBeli;
  double selisihHarga = hargaRokPolkadot - hargaKemeja;
  double hargaRataRata = (hargaKemeja + hargaRokPolkadot) / 2;
  int sisaPembagianStok = stokKemeja % 4;

  print('Pembelian $jumlahBeli Kemeja: Rp$totalHargaKemeja',);
  print('Sisa stok Kemeja: $sisaStokKemeja');
  print('Selisih harga kedua produk: Rp$selisihHarga');
  print('Rata-rata harga produk: Rp$hargaRataRata');
  print('Sisa pembagian stok Kemeja dengan 4: $sisaPembagianStok');

  print('\n--- 2. Operator Perbandingan ---');

  bool hargaKemejaSama = hargaKemeja == hargaRokPolkadot;
  bool hargaKemejaBerbeda = hargaKemeja != hargaRokPolkadot;
  bool rokLebihMahal = hargaRokPolkadot > hargaKemeja;
  bool kemejaLebihMurah = hargaKemeja < hargaRokPolkadot;
  bool stokKemejaCukup = stokKemeja >= jumlahBeli;
  bool stokKemejaSedikit = sisaStokKemeja <= 2;

  print('Apakah harga kemeja dan rok sama? $hargaKemejaSama');
  print('Apakah harga kedua produk berbeda? $hargaKemejaBerbeda');
  print('Apakah rok polkadot lebih mahal? $rokLebihMahal');
  print('Apakah kemeja lebih murah? $kemejaLebihMurah');
  print('Apakah stok kemeja cukup untuk dibeli? $stokKemejaCukup');
  print('Apakah sisa stok kemeja sudah sedikit? $stokKemejaSedikit');

  print('\n--- 3. Operator Logika ---');

  bool produkAktif = true;
  bool diskonAktif = false;

  bool kemejaLayakTampil =
      (stokKemeja > 0) && (hargaKemeja > 0);

  bool rokPerluRestock =
      (stokRokPolkadot < 10) || (stokRokPolkadot == 0);

  bool produkTidakAktif = !produkAktif;

  print('Apakah kemeja layak ditampilkan? $kemejaLayakTampil');
  print('Apakah rok polkadot perlu restock? $rokPerluRestock');
  print('Apakah diskon sedang tidak aktif? ${!diskonAktif}');
  print('Apakah produk tidak aktif? $produkTidakAktif');
}