import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black12,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            Image.asset('images/logo_ohmytag.png', width: 150),
            const Spacer(),
            _customButton(
              label: "S'inscrire",
              icon: Icons.add,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            const SizedBox(width: 8),
            _customButton(
              label: "Se connecter",
              icon: Icons.person,
              backgroundColor: const Color(0xFF592DF2),
              textColor: Colors.white,
              fontSize: 12,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          ],
        ),
      );
    }

    // Navbar Desktop
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/logo_ohmytag.png', width: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _navItem("Accueil"),
              _navItem("Scan"),
              _navItem("Wishlist"),
              _navItem("Contact"),
            ],
          ),
          Row(
            children: [
              _customButton(
                label: "S'inscrire",
                icon: Icons.add,
                backgroundColor: Colors.black,
                textColor: Colors.white,
              ),
              const SizedBox(width: 10),
              _customButton(
                label: "Se connecter",
                icon: Icons.person,
                backgroundColor: const Color(0xFF592DF2),
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 Menu mobile (Drawer)
  Widget buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 10),
            _drawerItem(context, "Accueil"),
            _drawerItem(context, "Scan"),
            _drawerItem(context, "Wishlist"),
            _drawerItem(context, "Contact"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _customButton({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    double fontSize = 14,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  }) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: textColor, size: 18),
      label: Text(label, style: TextStyle(color: textColor, fontSize: fontSize)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}