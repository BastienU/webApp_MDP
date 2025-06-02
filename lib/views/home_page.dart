import 'package:flutter/material.dart';
import '../layout/main_scaffold.dart';
import '../widgets/footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 800;
                  return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
                },
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customButton
  (
    {
    required String label,
    required Color backgroundColor,
    required Color textColor,
    double fontSize = 20,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    }
  ) 
  {
    return ElevatedButton
    (
      onPressed: () {},
      style: ElevatedButton.styleFrom
      (
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder
        (
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
      child: Text(label, style: TextStyle(color: textColor, fontSize: fontSize)),
    );
  }

  Widget _buildDesktopLayout() 
  {
  return SingleChildScrollView
  (
    child: Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: 
      [
        _buildHeroSection(),
        const SizedBox(height: 50),
        _buildPromoSection(),

        _buildInspirationSection(),

        _buildTestimonialsSection(),
      ],
    ),
  );
}

  Widget _buildHeroSection() 
  {
    return Padding
    (
      padding: const EdgeInsets.fromLTRB(200, 50, 0, 0),
      child: Row
      (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [
          Expanded
          (
            flex: 3,
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const 
              [
                Text
                (
                  'Oh My Tag',
                  style: TextStyle
                  (
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    fontFamily: 'CaviarDreams',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text
                (
                  'Votre application shopping\net dressing intelligente',
                  style: TextStyle
                  (
                    fontSize: 25,
                    fontFamily: 'CaviarDreams',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text
                (
                  'Donnez une suite à vos envies !',
                  style: TextStyle
                  (
                    fontSize: 20,
                    fontFamily: 'CaviarDreams',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                Text
                (
                  'Explorez vos marques préférées, organisez vos vêtements\net retrouvez vos coups de coeur.',
                  style: TextStyle
                  (
                    fontSize: 20,
                    fontFamily: 'CaviarDreams',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 50),
          Expanded
          (
            flex: 4,
            child: Stack
            (
              children: 
              [
                Positioned
                (
                  left: 500,
                  top: 0,
                  child: Container
                  (
                    width: 600,
                    height: 210,
                    decoration: BoxDecoration
                    (
                      color: const Color.fromARGB(255, 89, 45, 242),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                // Image au premier plan
                Container
                (
                  width: 1000,
                  height: 220,
                  decoration: BoxDecoration
                  (
                    image: DecorationImage
                    (
                      image: AssetImage('images/main.png'),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() 
  {
    return Container
    (
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          const Text
          (
            'L\'appli mode qui connecte votre dressing et vos envies',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              fontSize: 80,
              fontFamily: 'CaviarDreams',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          const Text
          (
            'Explorez des collections exclusives, suivez vos marques préférées, restez au courant des dernières tendances mode.',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              fontSize: 18,
              fontFamily: 'CaviarDreams',
              height: 1.4,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),

          Row
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              Expanded
              (
                flex: 3,
                child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const 
                  [
                    Text
                    (
                      'Promotions en temps réel',
                      style: TextStyle
                      (
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CaviarDreams',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text
                    (
                      'Oh My Tag s’adresse à toutes celles et ceux qui veulent gérer leur garde-robe avec intelligence, gagner du temps en shopping, et ne rater aucune opportunité de style.',
                      style: TextStyle
                      (
                        fontSize: 18,
                        fontFamily: 'CaviarDreams',
                        height: 1.4,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),

              Expanded
              (
                flex: 4,
                child: Container
                (
                  width: 600,
                  height: 300,
                  decoration: BoxDecoration
                  (
                    image: DecorationImage
                    (
                      image: AssetImage('images/promo.png'),
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInspirationSection() 
  {
    return Container
    (
      padding: const EdgeInsets.symmetric(horizontal: 200),
      alignment: Alignment.topLeft,
      child: Row
      (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [
          Expanded
          (
            flex: 1,
            child: Column
            (
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Image.asset('images/inspiration1.png', fit: BoxFit.cover),
                const SizedBox(height: 20),
                Image.asset('images/inspiration2.png', fit: BoxFit.cover),
              ],
            ),
          ),

          const SizedBox(width: 40),
          Expanded
          (
            flex: 1,
            child: Column
            (
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: 
              [
                Image.asset('images/inspiration3.png', fit: BoxFit.cover),
                const SizedBox(height: 10),
                Image.asset('images/inspiration4.png', fit: BoxFit.cover),
                const SizedBox(height: 10),
                Transform.rotate
                (
                  angle: 3.1416, 
                  child: Image.asset('images/inspiration3.png', fit: BoxFit.cover),
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),
          Expanded
          (
            flex: 2,
            child: Container
            (
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 40),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Text
                  (
                    'Trouvez l\'inspiration',
                    style: TextStyle
                    (
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CaviarDreams',
                      color: Colors.black,
                    )
                  ),

                  const SizedBox(height: 40),

                  Text
                  (
                    'Suivez vos marques préférées et restez au courant des dernières tendances mode.',
                    style: TextStyle
                    (
                      fontSize: 20,
                      fontFamily: 'CaviarDreams',
                      color: Colors.black,
                    )
                  ),

                  const SizedBox(height: 20),

                  Text
                  (
                    'Scannez, taguez et organisez vos vêtements, créez vos tenues, préparez vos achats et construisez votre style de manière simple et intuitive.',
                    style: TextStyle
                    (
                      fontSize: 20,
                      fontFamily: 'CaviarDreams',
                      color: Colors.black,
                    )
                  ),
                  
                  const SizedBox(height: 60),

                  Align
                  (
                    alignment: Alignment.centerLeft,
                    child: _customButton
                    (
                      label: "Explorer les tendances",
                      backgroundColor: const Color(0xFF592DF2),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() 
  {
    final List<String> testimonials = 
    [
      "“Super appli ! Elle a transformé ma façon de faire du shopping.”\n Julie",
      "“Oh My Tag a changé ma façon de faire du shopping ! Je peux enfin retrouver les pièces vues en boutique que j’adore, les enregistrer et les comparer plus tard. L’app est super fluide et les rappels quand un produit revient en stock sont ultra utiles. J’adore l’idée du dressing intelligent.”\n Chloe.C",
      "“Simple, rapide, efficace.”\n Clara",
    ];

    final PageController controller = PageController(viewportFraction: 0.7);

    return Container
    (
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50), 
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          const Text
          (
            'Ils en parlent mieux que nous',
            textAlign: TextAlign.center, 
            style: TextStyle
            (
              fontSize: 80, 
              fontFamily: 'CaviarDreams',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),

          SizedBox
          (
            height: 220,
            width: double.infinity,
            child: Center
            (
              child: Stack
              (
                alignment: Alignment.center,
                children: 
                [
                  PageView.builder
                  (
                    controller: controller,
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) 
                    {
                      return Padding
                      (
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card
                        (
                          elevation: 4,
                          shape: RoundedRectangleBorder
                          (
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white,
                          child: Center
                          (
                            child: Padding
                            (
                              padding: const EdgeInsets.all(20.0),
                              child: Text
                              (
                                testimonials[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle
                                (
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'CaviarDreams',
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Left arrow
                  Positioned
                  (
                    left: 0,
                    child: GestureDetector
                    (
                      onTap: () 
                      {
                        controller.previousPage
                        (
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container
                      (
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration
                        (
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.chevron_left, size: 30, color: Colors.black),
                      ),
                    ),
                  ),
                  // Right arrow
                  Positioned
                  (
                    right: 0,
                    child: GestureDetector
                    (
                      onTap: () 
                      {
                        controller.nextPage
                        (
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container
                      (
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration
                        (
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.chevron_right, size: 30, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() 
  {
    return SingleChildScrollView
    (
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [ 
          _buildMobileHeroSection(),
          const SizedBox(height: 40),
          _buildMobilePromoSection(),
          const SizedBox(height: 60),
          _buildMobileInspirationSection(),
          const SizedBox(height: 30),
          _buildMobileTestimonialsSection(),
        ],
      ),
    );
  }

  Widget _buildMobileHeroSection() 
  {
    return Padding
    (
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Text
          (
            'Oh My Tag !',
            style: TextStyle
            (
              fontWeight: FontWeight.bold,
              fontSize: 50,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text
          (
            'Votre application shopping et dressing\nintelligent',
            style: TextStyle
            (
              fontSize: 20,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text
          (
            'Donnez une suite à vos envies !',
            style: TextStyle
            (
              fontSize: 15,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          Text
          (
            'Explorez vos marques préférées, organisez vos\nvêtements\net retrouvez vos coups de coeur.',
            style: TextStyle
            (
              fontSize: 15,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),

          SizedBox
          (
            height: 170,
            child: Stack
            (
              children: 
              [
                  Positioned
                  (
                    left: 200,
                    top: 0,
                    child: Container
                    (
                      width: 600,
                      height: 170,
                      decoration: BoxDecoration
                      (
                        color: const Color.fromARGB(255, 89, 45, 242),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                Container
                (
                  decoration: BoxDecoration
  				        (
                    image: DecorationImage
  				          (
                      image: AssetImage('images/main.png'),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePromoSection() 
  {
    return Container
    (
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          const Text
          (
            'L\'appli mode qui connecte votre dressing et vos envies',
            textAlign: TextAlign.left,
            style: TextStyle
            (
              fontSize: 20,
              fontFamily: 'CaviarDreams',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text
          (
            'Explorez des collections exclusives et suivez vos marques préférées, restez au courant des dernières tendances mode.',
            textAlign: TextAlign.left,
            style: TextStyle
            (
              fontSize: 15,
              fontFamily: 'CaviarDreams',
              height: 1.4,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),

          Align
          (
            alignment: Alignment.centerRight,
            child: Container
            (
              width: double.infinity,
              decoration: BoxDecoration
              (
                borderRadius: const BorderRadius.only
                (
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Image.asset
              (
                'images/promo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 40),

          Align
          (
            alignment: Alignment.centerLeft,
            child: Text
            (
              'Promotions en temps réel',
              style: TextStyle
              (
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'CaviarDreams',
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Align
          (
            alignment: Alignment.centerLeft,
            child: Text
            (
              'Oh My Tag s’adresse à toutes celles et ceux qui veulent gérer leur garde-robe avec intelligence, gagner du temps en shopping, et ne rater aucune opportunité de style.',
              style: TextStyle
              (
                fontSize: 15,
                fontFamily: 'CaviarDreams',
                height: 1.4,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileInspirationSection() 
  {
    return Padding
    (
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column
      (
        children: 
        [
          const Text
          (
            'Trouvez l\'inspiration',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text
          (
            'Suivez vos marques préférées et restez au courant des dernières tendances mode.',
            style: const TextStyle
            (
              fontSize: 15,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text
          (
            'Scannez, taguez et organisez vos vêtements, créez vos tenues, préparez vos achats et construisez votre style de manière simple et intuitive.',
            style: const TextStyle
            (
              fontSize: 15,
              fontFamily: 'CaviarDreams',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _customButton
          (
            label: "Explorer les tendances",
            backgroundColor: const Color(0xFF592DF2),
            textColor: Colors.white,
          ),
          const SizedBox(height: 30),

          Row
          (
            children: 
            [
              Expanded
              (
                flex: 1,
                child: Container
                (
                  height: 180,
                  child: Transform.rotate
                  (
                    angle: 4.7124,
                    child: Image.asset('images/inspiration1.png', fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Expanded
              (
                flex: 1,
                child: Container
                (
                  height: 180,
                  child: Transform.rotate
                  (
                    angle: 1.5708,
                    child: Image.asset('images/inspiration1.png', fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTestimonialsSection() 
  {
    final List<String> testimonials = 
    [
      "“Super appli ! Elle a transformé ma façon de faire du shopping.”\n Julie",
      "“Enfin une app qui comprend mes goûts.”\n Sam",
      "“Simple, rapide, efficace.”\n Clara",
    ];
    final PageController controller = PageController(viewportFraction: 0.85);

    return Container
    (
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column
      (
        children: 
        [
          const Text
          (
            'Ils en parlent mieux que nous',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              fontSize: 40,
              fontFamily: 'CaviarDreams',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox
          (
            height: 220,
            child: PageView.builder
            (
              controller: controller,
              itemCount: testimonials.length,
              itemBuilder: (context, index) 
              {
                return Padding
                (
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card
                  (
                    elevation: 4,
                    shape: RoundedRectangleBorder
                    (
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(20.0),
                        child: Text
                        (
                          testimonials[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle
                          (
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'CaviarDreams',
                            height: 1.4,
                          ),
                        ),
                      ),
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


  Widget _drawerItem(BuildContext context, String title, String route) {
  return ListTile(
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, route);
    },
  );
}

}