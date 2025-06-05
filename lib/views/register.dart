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
  bool termsAccepted = false;

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? nameError;
  String? firstnameError;
  String? emailError;
  String? passwordError;
  String? termsError;

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

  Future<void> _registerUser() async {
    setState(() {
      nameError = nomController.text.isEmpty ? "Vous devez renseigner votre nom" : null;
      firstnameError = prenomController.text.isEmpty ? "Vous devez renseigner votre prénom" : null;
      emailError = emailController.text.isEmpty ? "Vous devez renseigner votre adresse e-mail" : null;
      passwordError = passwordController.text.length < 8 ? "Le mot de passe doit contenir au moins 8 caractères" : null;
      termsError = !termsAccepted ? "Vous devez accepter les termes et conditions" : null;
    });

    if (nameError != null || firstnameError != null || emailError != null || passwordError != null || termsError != null) {
      return;
    }

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
        'termsAccepted': termsAccepted,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else {
      final errorMessage = jsonDecode(response.body)['error'];

      if (errorMessage.contains("nom")) {
        setState(() {
          nameError = errorMessage;
        });
      } else if (errorMessage.contains("prenom")) {
        setState(() {
          firstnameError = errorMessage;
        });
      } else if (errorMessage.contains("email")) {
        setState(() {
          emailError = errorMessage;
        });
      } else if (errorMessage.contains("password")) {
        setState(() {
          passwordError = errorMessage;
        });
      } else {
        _showError(errorMessage);
      }
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
              Expanded(child: _buildTextField(label: 'Nom', controller: nomController, errorText: nameError)),
              const SizedBox(width: 10),
              Expanded(child: _buildTextField(label: 'Prénom', controller: prenomController, errorText: firstnameError)),
            ],
          ),
          const SizedBox(height: 15),
          _buildTextField(label: 'Adresse e-mail', controller: emailController, errorText: emailError),
          const SizedBox(height: 15),
          _buildTextField(label: 'Mot de passe (8 caractères minimum)', obscure: true, controller: passwordController, errorText: passwordError),
          const SizedBox(height: 15),
          
          Row(
            children: [
              Checkbox(
                value: termsAccepted,
                activeColor: const Color(0xFF592DF2),
                onChanged: (value) {
                  setState(() {
                    termsAccepted = value!;
                  });
                },
              ),
              const Expanded(
                child: Text(
                  "J'accepte les termes et conditions",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          if (termsError != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                termsError!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),

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
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? errorText,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
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
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

   Widget _buildRadioOption(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 5),
        Radio<String>(
          value: label,
          groupValue: selectedGender,
          activeColor: const Color(0xFF592DF2),
          onChanged: (val) {
            setState(() {
              selectedGender = val;
            });
          },
        ),
      ],
    );
  }
}