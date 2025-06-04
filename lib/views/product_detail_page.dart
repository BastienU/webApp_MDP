import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_app/api_service.dart';
import 'package:web_app/widgets/footer.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FÉLICITATIONS'),
        backgroundColor: const Color.fromARGB(255, 89, 45, 242),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            color: const Color.fromARGB(255, 89, 45, 242),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Center(
              child: Text(
                'Votre scan a été réalisé avec succès !',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Voici le produit scanné :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 10),
          if (product['image'] != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product['image'],
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nom : ${product['name'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Prix : ${product['price'] ?? 'N/A'} €",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Composition : ${product['composition'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Description :\n${product['description'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Code barre : ${product['code'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final String? token = await storage.read(key: 'token');

                      if (token == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Utilisateur non connecté")),
                        );
                        return;
                      }

                      final selectedWishlistId = await _selectWishlist(context);
                      if (selectedWishlistId != null) {
                        final response = await _apiService.addProductToWishlist(token, selectedWishlistId, product['id']);

                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Produit ajouté à la wishlist")),
                          );
                        } else {
                          print("Erreur lors de l'ajout: ${response.body}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Erreur lors de l'ajout: ${response.body}")),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text(
                      "Ajouter à ma wishlist",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Footer(),
        ],
      ),
    );
  }


  Future<int?> _selectWishlist(BuildContext context) async {
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Utilisateur non connecté")),
      );
      return null;
    }

    try {
      final List<dynamic> wishlists = await _apiService.getAllWishlists(token);

      if (wishlists.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Aucune wishlist trouvée")),
        );
        return null;
      }

      return await showDialog<int>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Sélectionner une wishlist"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: wishlists.length,
                itemBuilder: (context, index) {
                  final wishlist = wishlists[index];
                  return ListTile(
                    title: Text(wishlist['name']),
                    onTap: () {
                      Navigator.pop(dialogContext, wishlist['id']);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } catch (error) {
      print("Erreur lors de la récupération des wishlists: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Impossible de récupérer les wishlists")),
      );
      return null;
    }
  }

}