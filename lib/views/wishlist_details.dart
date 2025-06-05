import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/config.dart';
import 'dart:convert';
import '../layout/main_scaffold.dart';
import '../api_service.dart';
import 'product_detail_page.dart';

class WishlistDetailsPage extends StatefulWidget {
  final int wishlistId;
  const WishlistDetailsPage({super.key, required this.wishlistId});

  @override
  State<WishlistDetailsPage> createState() => _WishlistDetailsPageState();
}

class _WishlistDetailsPageState extends State<WishlistDetailsPage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late Future<List<dynamic>> _products = Future.value([]);

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
    if (token == null) {
      return;
    }

    final fetchedProducts = await _fetchProducts(token, widget.wishlistId);

    setState(() {
      _products = Future.value(fetchedProducts.isNotEmpty ? fetchedProducts : []);
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProducts();
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

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Erreur"),
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

  void _removeProduct(int productId) async {
    final token = await _getToken();
    if (token != null) {
      final response = await _apiService.removeProductFromWishlist(token, widget.wishlistId, productId);
      
      if (response.statusCode == 200) {
        _loadProducts();
        _showSuccess("Produit supprimé de la wishlist");
      } else {
        _showError("Erreur lors de la suppression");
      }
    }
  }


  Future<void> _navigateToProductDetail(String productCode) async {
    final response = await http.get(Uri.parse('$apiBaseUrl/api/products/code/$productCode'));
    if (response.statusCode == 200) {
      final product = jsonDecode(response.body);
      if (!mounted) return;
      
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: product),
        ),
      );

      _loadProducts();
    } else {
      _showError("Produit non trouvé");
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
            child: const Center(
              child: Text(
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
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Aucun produit trouvé dans cette wishlist."));
                }

                final products = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    if (product == null || !product.containsKey('name') || !product.containsKey('image')) {
                      return const ListTile(title: Text("Produit invalide"));
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        key: ValueKey(product['id']),
                        leading: SizedBox(
                          width: 50,
                          child: product['image'] != null 
                            ? Image.network(
                              "$apiBaseUrl/proxy?url=${Uri.encodeComponent(product['image'])}",
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
                            )
                            : const Icon(Icons.image_not_supported, size: 50),
                        ),
                        title: Text(product['name'] ?? "Nom inconnu"),
                        subtitle: Text("Prix : ${product['price'] ?? "Non renseigné"}€"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _removeProduct(product['id']);
                          },
                        ),
                        onTap: () {
                          _navigateToProductDetail(product['code']);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )
          // const Footer(),
        ],
      ),
    );
  }
}