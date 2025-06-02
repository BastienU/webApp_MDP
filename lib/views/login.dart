import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/footer.dart';
import '../views/register.dart';
import '../config.dart';
import '../views/home_page.dart';
import '../views/dashboard.dart';
import '../layout/main_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await _isAuthenticated();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  Future<String?> _getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> _saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return "L'email est requis.";
    if (!RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      return "Format d'email invalide.";
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return "Le mot de passe est requis.";
    if (password.length < 8) return "Le mot de passe doit contenir au moins 8 caractères.";
    return null;
  }
  Future<bool> _isAuthenticated() async {
    final token = await _getToken();
    return token != null;
  }

  Future<void> _loginUser() async {
    final emailError = _validateEmail(emailController.text);
    final passwordError = _validatePassword(passwordController.text);

    if (emailError != null || passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(emailError ?? passwordError!)));
      return;
    }

    final response = await http.post(
      Uri.parse('$apiBaseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final token = json['token'];

      await _saveToken(token);
      setState(() {});

      final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1]))));
      final String role = payload['role'];

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connexion réussie !')));

      if (role == 'retailer') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    } else {
      final error = jsonDecode(response.body)['error'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.contains("incorrect") ? "Email ou mot de passe incorrect." : error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            _buildLoginFormSection(context),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF592DF2),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: const [
          Text(
            'RECONNEXION',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
          ),
          SizedBox(height: 10),
          Text(
            'À vos envies',
            style: TextStyle(fontSize: 18, color: Colors.white70, fontFamily: 'CaviarDreams'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginFormSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Se connecter',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'CaviarDreams'),
          ),
          const SizedBox(height: 20),
          _buildTextField(label: 'Adresse e-mail', controller: emailController),
          const SizedBox(height: 20),
          _buildTextField(label: 'Mot de passe', controller: passwordController, obscure: true),
          const SizedBox(height: 25),
          FutureBuilder<bool>(
            future: _isAuthenticated(),
            builder: (context, snapshot) {
              final isLoggedIn = snapshot.data ?? false;
              return isLoggedIn
                  ? Container() // ✅ Masque le bouton si connecté
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF592DF2),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _loginUser();
                        },
                        child: const Text(
                          'Se connecter à mon espace',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    );
            },
          ),
          const SizedBox(height: 15),
          Center(
            child: FutureBuilder<bool>(
              future: _isAuthenticated(),
              builder: (context, snapshot) {
                final isLoggedIn = snapshot.data ?? false;
                return isLoggedIn
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Vous n\'avez pas encore de compte ? ',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            children: [
                              TextSpan(
                                text: 'Inscrivez-vous !',
                                style: TextStyle(color: Color(0xFF592DF2), fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}