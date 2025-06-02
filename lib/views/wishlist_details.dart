import 'package:flutter/material.dart';
import 'package:web_app/layout/main_scaffold.dart';
import '../widgets/footer.dart';

class WishlistDetailsPage extends StatelessWidget {
  final String title;
  const WishlistDetailsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Montre connectée', 'price': '149€', 'image': 'assets/images/watch.png'},
      {'name': 'Casque Bluetooth', 'price': '99€', 'image': 'assets/images/headphones.png'},
    ];

    return MainScaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF592DF2),
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(product['image']!, width: 50, height: 50),
                    title: Text(product['name']!),
                    trailing: Text(product['price']!),
                  ),
                );
              },
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}