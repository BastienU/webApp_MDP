import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_app/views/wishlist_details.dart';
import '../layout/main_scaffold.dart';
import '../api_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late Future<List<dynamic>> _wishlists;

  String? createWishlistError;
  String? renameWishlistError;

  @override
  void initState() {
    super.initState();
    _loadWishlists();
  }

  Future<String?> _getToken() async {
    return await storage.read(key: 'token');
  }

  Future<int?> _getUserIdFromToken() async {
  final String? token = await storage.read(key: 'token');

  if (token == null) return null;

  final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  return decodedToken['id'];
}

  void _loadWishlists() async {
    final token = await _getToken();
    if (token != null) {
      setState(() {
        _wishlists = _apiService.getUserWishlists(token);
      });
    } else {
      print('Token introuvable, utilisateur non connecté.');
    }
  }

  void _createWishlist() async {
  final TextEditingController nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        title: const Text("Créer une nouvelle wishlist"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nom de la wishlist"),
            ),
            if (createWishlistError != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  createWishlistError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
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
              final token = await _getToken();
              final int? userId = await _getUserIdFromToken();

              if (nameController.text.trim().isEmpty) {
                setDialogState(() {
                  createWishlistError = "Le nom de la wishlist est requis.";
                });
                return;
              }

              if (token != null && userId != null) {
                await _apiService.createWishlist(token, nameController.text, userId);
                _loadWishlists();
              } else {
                setDialogState(() {
                  createWishlistError = "Utilisateur non connecté.";
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Créer"),
          ),
        ],
      ),
    ),
  );
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

  void _renameWishlist(int wishlistId) async {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Renommer la wishlist"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nouveau nom"),
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
                  setDialogState(() {
                    renameWishlistError = "Veuillez saisir un nom !";
                  });
                  return;
                }

                final token = await _getToken();
                if (token != null) {
                  final response = await _apiService.renameWishlist(token, wishlistId, nameController.text);
                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                    _loadWishlists();
                    _showSuccess("Wishlist renommée avec succès !");
                  } else {
                    _showError("Erreur lors du renommage.");
                  }
                }
              },
              child: const Text("Renommer"),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteWishlist(int wishlistId) async {
    final token = await _getToken();
    if (token != null) {
      final response = await _apiService.deleteWishlist(token, wishlistId);
      if (response.statusCode == 200) {
        _loadWishlists();
        _showSuccess("Wishlist supprimée avec succès !");
      } else {
        _showError("Erreur lors de la suppression.");
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
        ],
      ),
    );
  }
}