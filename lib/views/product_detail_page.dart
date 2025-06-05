import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_app/api_service.dart';
import 'package:web_app/config.dart';
import 'package:web_app/widgets/footer.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? wishlistError;
  String? selectedWishlistName;

  Future<void> _addToWishlist() async {
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      setState(() {
        wishlistError = "Utilisateur non connecté.";
      });
      return;
    }

    final selectedWishlist = await _selectWishlist(context, token);
    if (selectedWishlist == null) {
      setState(() {
        wishlistError = "Veuillez sélectionner une wishlist.";
      });
      return;
    }

    final response = await _apiService.addProductToWishlist(token, selectedWishlist['id'], widget.product['id']);

    if (response.statusCode == 201) {
      setState(() {
        wishlistError = null;
      });

      _showSuccess("Produit ajouté à la wishlist '${selectedWishlist['name']}'");
      
    } else {
      setState(() {
        wishlistError = "Erreur lors de l'ajout : ${response.body}";
      });
    }
  }

  Future<Map<String, dynamic>?> _selectWishlist(BuildContext context, String token) async {
    if (token.isEmpty) {
      setState(() {
        wishlistError = "Utilisateur non connecté.";
      });
      return null;
    }

    try {
      final List<dynamic> wishlists = await _apiService.getUserWishlists(token);

      if (wishlists.isEmpty) {
        setState(() {
          wishlistError = "Aucune wishlist trouvée.";
        });
        return null;
      }

      return await showDialog<Map<String, dynamic>>(
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
                      Navigator.pop(dialogContext, wishlist);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } catch (error) {
      setState(() {
        wishlistError = "Impossible de récupérer les wishlists.";
      });
      return null;
    }
  }

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Succès"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FÉLICITATIONS'),
        backgroundColor: const Color(0xFF592DF2),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            color: const Color(0xFF592DF2),
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
            child: const Text(
              'Voici le produit scanné :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 10),
          if (widget.product['image'] != null)
            Center(
              child: Image.network(
                "$apiBaseUrl/proxy?url=${Uri.encodeComponent(widget.product['image'])}",
                width: 250,
                height: 200,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 50);
                },
              ),
            ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nom : ${widget.product['name'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Prix : ${widget.product['price'] ?? 'N/A'} €",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Composition : ${widget.product['composition'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Description :\n${widget.product['description'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Code barre : ${widget.product['code'] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: _addToWishlist,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: const Text(
                          "Ajouter à ma wishlist",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      if (wishlistError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            wishlistError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
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
}