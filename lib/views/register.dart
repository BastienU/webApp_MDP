import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';
import 'login.dart';
import '../config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedGender;
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _registerUser() async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/api/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'genre': selectedGender,
        'name': nomController.text,
        'firstname': prenomController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'role': 'user',
        'termsAccepted': true,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Inscription réussie !')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur : ${jsonDecode(response.body)['error']}')));
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
            _buildRegisterFormSection(context),
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
            'BIENVENUE !',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Merci d’avoir choisi\nOh My Tag !',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontFamily: 'CaviarDreams',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterFormSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Créer un compte',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'CaviarDreams',
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sexe :", style: TextStyle(fontSize: 16)),
              const SizedBox(width: 20),
              _buildRadioOption("H", "Homme"),
              const SizedBox(width: 20),
              _buildRadioOption("F", "Femme"),
              const SizedBox(width: 20),
              _buildRadioOption("Autre", "Autre"),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(child: _buildTextField(label: 'Nom', controller: nomController)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField(label: 'Prénom', controller: prenomController)),
            ],
          ),
          const SizedBox(height: 15),
          _buildTextField(label: 'Adresse e-mail', controller: emailController),
          const SizedBox(height: 15),
          _buildTextField(label: 'Mot de passe (8 caractères minimum)', obscure: true, controller: passwordController),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF592DF2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _registerUser,
              child: const Text(
                'Finaliser mon inscription',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Vous avez déjà un compte ? ',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  children: [
                    TextSpan(
                      text: 'Se connecter à mon compte',
                      style: TextStyle(color: Color(0xFF592DF2), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedGender,
          activeColor: const Color(0xFF592DF2),
          onChanged: (val) {
            setState(() {
              selectedGender = val;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}