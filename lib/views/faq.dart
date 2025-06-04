import 'package:flutter/material.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

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
                'Foire Aux Questions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestion(
                    "Comment fonctionne l'application Oh My Tag ?",
                    "Comment scanner un produit en boutique ?\nEst-ce que l'application est gratuite ?\nComment recevoir des alertes sur un produit ?\nEst-ce que je peux utiliser l'application sans internet ?",
                  ),
                  _buildQuestion(
                    "Puis-je organiser mes vêtements dans l’application ?",
                    "Est-ce que je peux créer des tenues ou des looks ?\nPuis-je taguer des vêtements déjà en ma possession ?",
                  ),
                  _buildQuestion(
                    "Comment créer un compte Oh My Tag ?",
                    "Puis-je utiliser l’appli sans créer de compte ?\nMes données sont-elles sécurisées ?\nComment supprimer mon compte et mes données ?",
                  ),
                  _buildQuestion(
                    "Je suis commerçant, comment intégrer Oh My Tag ?",
                    "Comment fonctionne l’interface commerçant ?\nQue puis-je voir dans le tableau de bord ?\nPuis-je envoyer des promotions à mes clients ?\nQuel est le coût pour les commerçants ?\nPuis-je tester gratuitement Oh My Tag ?",
                  ),
                ],
              ),
            ),
          ),
          // const Footer(),
        ],
      ),
    );
  }

  Widget _buildQuestion(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}