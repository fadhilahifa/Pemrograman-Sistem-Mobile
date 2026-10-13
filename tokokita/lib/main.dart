import 'package:flutter/material.dart';
import 'package:tokokita/screens/home_page.dart';
import 'package:tokokita/screens/main_page.dart';
import 'screens/product_detail_page.dart';
import 'models/product.dart';
import 'screens/login_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // set route awal
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Product?;
          if (args != null) {
            return ProductDetailPage(product: args);
          } else {
            return const Scaffold(
              body: Center(child: Text('Produk tidak ditemukan')),
            );
          }
        },
      },
    );
  }
}