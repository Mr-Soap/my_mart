import 'package:flutter/material.dart';
import 'package:my_mart/models/shop.dart';
import 'package:my_mart/pages/cart_page.dart';
import 'package:my_mart/pages/login_page.dart';
import 'package:my_mart/pages/shop_pages.dart';
import 'package:my_mart/themes/light_mode.dart';
import 'package:provider/provider.dart';
import 'pages/intro_page.dart';
import 'package:my_mart/models/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // penting kalau pakai async di main

  final shop = Shop();
  await shop.loadProductsFromXml(); // load XML sebelum runApp

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => shop),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: lightMode,
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/cart_page': (context) => const CartPage(),
        '/shop_page': (context) => ShopPage(),
        '/login_page': (context) => LoginPage(),
      },
    );
  }
}
