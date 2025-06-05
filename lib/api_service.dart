import 'dart:convert';
import 'config.dart';
import 'package:http/http.dart' as http;

class ApiService {

  // Register
  static Future<http.Response> registerUser({
    required String gender,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    final url = Uri.parse('$apiBaseUrl/signup');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'gender': gender,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      }),
    );
  }

  // Connection
  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) {
    final url = Uri.parse('$apiBaseUrl/login');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }

  // Récupérer toutes les wishlists
  Future<List<dynamic>> getAllWishlists(String token) async {
    final url = Uri.parse('$apiBaseUrl/api/wishlist');
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des wishlists');
    }
  }

  // Récupérer les wishlists de l'utilisateur connecté
  Future<List<dynamic>> getUserWishlists(String token) async {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/user');
    final response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des wishlists');
    }
  }


  // Récupérer les produits d'une wishlist
  Future<http.Response> getAllProductsFromWishlist(String token, int wishlistId) {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/$wishlistId/products');
    return http.get(url, headers: {'Authorization': 'Bearer $token'});
  }

  // Créer une nouvelle wishlist
  Future<http.Response> createWishlist(String token, String name, int userId) {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/create');
    return http.post(
      url,
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'user_id': userId}),
    );
  }

  // Renommer une wishlist
  Future<http.Response> renameWishlist(String token, int wishlistId, String newName) {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/$wishlistId');
    return http.put(
      url,
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({'name': newName}),
    );
  }

  // Supprimer une wishlist
  Future<http.Response> deleteWishlist(String token, int wishlistId) {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/$wishlistId');
    return http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  // Ajouter un produit à une wishlist
  Future<http.Response> addProductToWishlist(String token, int wishlistId, int productId) {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/$wishlistId/add/$productId');
    return http.post(
      url,
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({'wishlistId': wishlistId, 'productId': productId}),
    );
  }


  // Supprimer un produit d'une wishlist
  Future<http.Response> removeProductFromWishlist(String token, int wishlistId, int productId) {
    final url = Uri.parse('$apiBaseUrl/api/wishlist/$wishlistId/remove/$productId');
    return http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
  }

}