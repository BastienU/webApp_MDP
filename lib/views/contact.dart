import 'package:flutter/material.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFF592DF2),
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: const Center(
                child: Text(
                  'Contactez-nous',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('📞 Téléphone : +33 1 23 45 67 89'),
                  SizedBox(height: 10),
                  Text('📧 Email : ohmytag.support@gmail.com'),
                  SizedBox(height: 10),
                  Text('🏢 Adresse : 40 Rue du chemin vert, 75000 Paris, France'),
                  SizedBox(height: 20),
                  Text('Notre équipe est disponible du lundi au vendredi de 9h à 17h.'),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}