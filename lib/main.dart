import 'package:flutter/material.dart';
import 'package:web_app/views/home_page.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oh My Tag !', // Title of the tab
      theme: ThemeData
      (
        colorScheme: ColorScheme.fromSeed
        (
          seedColor: const Color.fromARGB(255, 9, 9, 216),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}