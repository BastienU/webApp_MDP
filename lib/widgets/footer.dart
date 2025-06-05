import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_app/views/about.dart';
import 'package:web_app/views/contact.dart';
import 'package:web_app/views/faq.dart';
import 'package:web_app/views/generals_gonditions.dart';

class Footer extends StatelessWidget 
{
  const Footer({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    return isMobile ? _buildMobileFooter(context) : _buildDesktopFooter(context);
  }

  // Footer Desktop
  Widget _buildDesktopFooter(BuildContext context) 
  {
    return Container
    (
      color: const Color.fromARGB(255, 89, 45, 242),
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
      child: Row
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Expanded
          (
            flex: 2,
            child: Container
            (
              padding: const EdgeInsets.all(100),
              decoration: const BoxDecoration
              (
                image: DecorationImage
                (
                  image: AssetImage('images/logo_ohMyTag_white.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded
          (
            flex: 2,
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                _sectionTitle('A PROPOS DE OH MY TAG !'),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _buildLinkList(
                    [
                      'À propos de nous',
                      'F.A.Q',
                      'Nous contacter',
                      'Conditions générales',
                    ],
                    [
                      AboutPage(),
                      FAQPage(),
                      ContactPage(),
                      GeneralsConditionsPage(),
                    ],
                    context,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 40),
          Expanded
          (
            flex: 2,
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                _sectionTitle('SUIVEZ-NOUS SUR NOS RESEAUX SOCIAUX !'),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _openInstagram,
                    child: Image.asset('images/logo_insta_white.png', width: 40, height: 40),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Footer Mobile
  Widget _buildMobileFooter(BuildContext context) 
  {
    return Container
    (
      color: const Color.fromARGB(255, 89, 45, 242),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column
      (
        children: 
        [
          Container
          (
            height: 150,
            decoration: const BoxDecoration
            (
              image: DecorationImage
              (
                image: AssetImage('images/logo_ohMyTag_footer.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 30),
          _sectionTitle('A PROPOS DE OH MY TAG !'),
          _buildLinkList(
          [
            'À propos de nous',
            'F.A.Q',
            'Nous contacter',
            'Conditions générales',
          ],
          [
            AboutPage(),
            FAQPage(),
            ContactPage(),
            GeneralsConditionsPage(),
          ],
          context,
        ),

        const SizedBox(height: 30),
          _sectionTitle('SUIVEZ-NOUS SUR\nNOS RESEAUX SOCIAUX !'),
          GestureDetector(
            onTap: _openInstagram,
            child: Image.asset('images/logo_insta_white.png', width: 40, height: 40),
          ),
        ],
      ),
    );
  }


  Widget _sectionTitle(String title) 
  {
    return Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: 
      [
        Text
        (
          title,
          style: const TextStyle
          (
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'CaviarDreams',
          ),
        ),
        const SizedBox(height: 8),
        Container(width: 240, height: 2, color: Colors.white),
        const SizedBox(height: 15),
      ],
    );
  }

  void _openInstagram() async {
    final Uri url = Uri.parse('https://www.instagram.com/_ohmytag_?utm_source=ig_web_button_share_sheet&igsh=bGN3aDc0enFpcGsx');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir l\'URL : $url';
    }
  }
}

// Function to build a list of links
  Widget _buildLinkList(List<String> titles, List<Widget> destinations, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
      titles.length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => destinations[index]),
            );
          },
          child: Text(
            '• ${titles[index]}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'CaviarDreams',
            ),
          ),
        ),
      ),
    ),
  );
}