import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';
import '../api_service.dart';
import 'dart:convert';

class WishlistDetailsPage extends StatefulWidget {
  final int wishlistId;
  const WishlistDetailsPage({super.key, required this.wishlistId});

  @override
  State<WishlistDetailsPage> createState() => _WishlistDetailsPageState();
}

class _WishlistDetailsPageState extends State<WishlistDetailsPage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late Future<List<dynamic>> _products;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<String?> _getToken() async {
    return await storage.read(key: 'token');
  }

  Future<List<dynamic>> _fetchProducts(String token, int wishlistId) async {
    final response = await _apiService.getAllProductsFromWishlist(token, wishlistId);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des produits');
    }
  }

  void _loadProducts() async {
    final token = await _getToken();
    if (token != null) {
      setState(() {
        _products = _fetchProducts(token, widget.wishlistId);
      });
    } else {
      print('Token introuvable, utilisateur non connecté.');
    }
  }

  void _removeProduct(int productId) async {
    final token = await _getToken();
    if (token != null) {
      final response = await _apiService.removeProductFromWishlist(token, widget.wishlistId, productId);
      if (response.statusCode == 200) {
        _loadProducts();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Produit supprimé de la wishlist")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Erreur lors de la suppression")));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF592DF2),
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: const Text(
                "Détails de la wishlist",
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erreur : ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Aucun produit trouvé dans cette wishlist."));
                }

                final products = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(product['image'], width: 50, height: 50),
                        title: Text(product['name']),
                        subtitle: Text("Prix : ${product['price']}€"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _removeProduct(product['id']);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // const Footer(),
        ],
      ),
    );
  }
}