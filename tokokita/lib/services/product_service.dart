import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // 1. Ubah response.body (string JSON) menjadi List<dynamic> menggunakan jsonDecode
        List<dynamic> body = jsonDecode(response.body);

        // 2. Petakan setiap item JSON menjadi objek Product menggunakan Product.fromJson
        List<Product> products = body
            .map((dynamic item) => Product.fromJson(item))
            .toList();

        return products;
      } else {
        throw Exception('Gagal memuat produk dari server (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  //  Mengambil detail satu produk berdasarkan ID
  Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        // Decode response JSON tunggal menjadi Map
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // Ubah menjadi objek Product menggunakan Product.fromJson
        return Product.fromJson(data);
      } else {
        throw Exception('Gagal memuat detail produk (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }
}

