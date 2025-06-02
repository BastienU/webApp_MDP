import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://mydigitalproject-production.up.railway.app/api';

  // ➕ Inscription
  static Future<http.Response> registerUser({
    required String gender,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) {
    final url = Uri.parse('$baseUrl/signup');
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

  // 🔐 Connexion
  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) {
    final url = Uri.parse('$baseUrl/login');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }
}