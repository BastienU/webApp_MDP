import 'package:flutter/material.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';

class GeneralsConditionsPage extends StatelessWidget {
  const GeneralsConditionsPage({super.key});

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
                'Conditions Générales',
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
                  _buildSection(
                    "Oh My Tag!",
                    "Oh My Tag! est une solution digitale et physique combinée qui révolutionne l’expérience d’achat en magasin. Elle crée un lien direct entre les consommateurs et les commerçants grâce à une application innovante permettant de capturer et suivre les intentions d’achat en magasin.",
                  ),
                  _buildSection(
                    "Accès à l’application",
                    "L’accès à l’application est gratuit. Certaines fonctionnalités nécessitent la création d’un compte utilisateur. L’accès Premium est payant selon les tarifs affichés dans l’application. Les commerçants disposent d’un accès dédié via un compte professionnel.",
                  ),
                  _buildSection(
                    "Fonctionnalités principales",
                    "- Scanner un produit via QR code en boutique\n- Ajouter un article à sa wishlist\n- Recevoir des alertes personnalisées (stock, promotions)",
                  ),
                  _buildSection(
                    "Données personnelles",
                    "Oh My Tag collecte certaines données pour assurer le bon fonctionnement du service. Ces données sont stockées de manière sécurisée et ne sont jamais revendues. L’utilisateur peut à tout moment demander l’accès, la modification ou la suppression de ses données en nous contactant : ohmytag.support@gmail.com",
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

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}