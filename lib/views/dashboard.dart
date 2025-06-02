import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tableau de bord Retailer")),
      body: const Center(child: Text("Bienvenue dans le dashboard !")),
    );
  }
}