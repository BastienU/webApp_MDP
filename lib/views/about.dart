import 'package:flutter/material.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                'À propos de Oh My Tag',
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
                    "Qu’est ce qu’Oh my tag! ?",
                    "Tout a commencé avec un geste simple, presque universel. Vous êtes dans une boutique, vous tombez sur cette veste parfaite qui vous fait de l’œil. Vous n’êtes pas sûr de l’acheter tout de suite, alors vous faites comme tout le monde : vous la prenez en photo. Un réflexe anodin, mais derrière cette habitude, on a vu quelque chose de bien plus grand. On a vu des milliers d’envies, des milliers d’intentions… qui disparaissent. Des produits repérés mais oubliés, des coups de cœur jamais concrétisés. Et surtout, on a vu une opportunité ..."
                    "\nC’est là qu’on a eu l’idée de Oh My Tag ! : Une solution simple, fluide, intuitive comme ce geste de prendre une photo.",
                  ),
                  _buildSection(
                    "Une application qui transforme chaque envie en opportunité.",
                    "Les clients scannent, sauvegardent et retrouvent leurs envies en un clic, comme une wishlist permanente, enrichie d’infos, de tailles, de disponibilités. Derrière chaque article scanné, il y a une histoire qui commence, celle d’un produit qui attend d’être aimé et d’une boutique qui veut comprendre ses clients."
                    "\nOh My Tag! c’est plus qu’un outil. C’est une façon de repenser l’expérience d’achat pour qu’aucune envie ne soit plus jamais perdue.",
                  ),
                  _buildSection(
                    "Oh My Tag! c’est plus qu’un outil. C’est une façon de repenser l’expérience d’achat pour qu’aucune envie ne soit plus jamais perdue.",
                    ""
                    )
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