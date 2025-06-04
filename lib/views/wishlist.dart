import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_app/views/wishlist_details.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';
import '../api_service.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late Future<List<dynamic>> _wishlists;

  @override
  void initState() {
    super.initState();
    _loadWishlists();
  }

  Future<String?> _getToken() async {
    return await storage.read(key: 'token');
  }

  void _loadWishlists() async {
    final token = await _getToken();
    if (token != null) {
      setState(() {
        _wishlists = _apiService.getAllWishlists(token);
      });
    } else {
      print('Token introuvable, utilisateur non connecté.');
    }
  }

  void _createWishlist() async {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Créer une nouvelle wishlist"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Nom de la wishlist"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              final token = await _getToken();
              if (token != null) {
                await _apiService.createWishlist(token, nameController.text, 1);
                _loadWishlists();
              } else {
                print("Utilisateur non connecté, impossible de créer une wishlist.");
              }
              Navigator.pop(context);
            },
            child: const Text("Créer"),
          ),
        ],
      ),
    );
  }

  void _renameWishlist(int wishlistId) async {
    final TextEditingController nameController = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Renommer la wishlist"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nouveau nom",
                      errorText: errorText,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Annuler"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty) {
                      setState(() {
                        errorText = "Veuillez saisir un nom !";
                      });
                      return;
                    }

                    final token = await _getToken();
                    if (token != null) {
                      final response = await _apiService.renameWishlist(token, wishlistId, nameController.text);
                      if (response.statusCode == 200) { 
                        _loadWishlists();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wishlist renommée")));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Erreur lors du renommage")));
                      }
                    }
                  },
                  child: const Text("Renommer"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteWishlist(int wishlistId) async {
    final token = await _getToken();
    if (token != null) {
      final response = await _apiService.deleteWishlist(token, wishlistId);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _loadWishlists();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? "Wishlist supprimée")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de la suppression")),
        );
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
              child: Column(
                children: [
                  const Text(
                    'Mes Wishlists',
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: _createWishlist,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text("Créer une nouvelle wishlist"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _wishlists,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erreur : ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Aucune wishlist trouvée."));
                }

                final wishlists = snapshot.data!;
                return ListView.builder(
                  itemCount: wishlists.length,
                  itemBuilder: (context, index) {
                    final wishlist = wishlists[index];
                    return ListTile(
                      title: Text(wishlist['name']),
                      trailing: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == "rename") {
                            _renameWishlist(wishlist['id']);
                          } else if (value == "delete") {
                            _deleteWishlist(wishlist['id']);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: "rename", child: Text("Renommer")),
                          const PopupMenuItem(value: "delete", child: Text("Supprimer")),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WishlistDetailsPage(wishlistId: wishlist['id']),
                          ),
                        );
                      },
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