import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'layout/main_scaffold.dart';
import 'views/home_page.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/contact.dart';
import 'views/barcode_scanner_page.dart';
import 'views/wishlist.dart';
import 'security/auth_guard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oh My Tag !',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 9, 9, 216),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/scanner': (context) => AuthGuard(protectedPage: const BarcodeScannerPage()), // 🔥 Route sécurisée
        '/contact': (context) => AuthGuard(protectedPage: const ContactPage()), // 🔥 Route sécurisée
        '/wishlist': (context) => AuthGuard(protectedPage: const WishlistPage()), // 🔥 Route sécurisée
      },
    );
  }
}