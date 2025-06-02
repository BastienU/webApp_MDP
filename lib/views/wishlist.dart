import 'package:flutter/material.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';
import 'wishlist_details.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> wishlists = ['Ma Liste Noël 🎄', 'Idées Cadeaux 🎁', 'Tech 🔌'];

    return MainScaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF592DF2),
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: const Center(
              child: Text(
                'Mes Wishlists',
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wishlists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(wishlists[index]),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WishlistDetailsPage(title: wishlists[index]),
                      ),
                    );
                  },
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
