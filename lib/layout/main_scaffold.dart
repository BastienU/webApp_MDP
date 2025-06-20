import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  const MainScaffold({super.key, required this.body});

  Future<bool> _isAuthenticated() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  Future<void> _logout(BuildContext context) async {
    await storage.delete(key: 'token');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () => _navigateTo(context, "/"),
              child: Image.asset('images/logo_ohmytag.png', width: 100),
            ),
            const SizedBox(width: 20),
            if (isDesktop)
              FutureBuilder<bool>(
                future: _isAuthenticated(),
                builder: (context, snapshot) {
                  final isLoggedIn = snapshot.data ?? false;
                  return Row(
                    children: [
                      _navItem(context, 'Accueil', '/'),
                      if (isLoggedIn) _navItem(context, 'Scanner', '/scanner'),
                      if (isLoggedIn) _navItem(context, 'Wishlist', '/wishlist'),
                      _navItem(context, 'Contact', '/contact'),
                      isLoggedIn
                          ? TextButton(
                              onPressed: () => _logout(context),
                              style: TextButton.styleFrom(foregroundColor: Colors.black),
                              child: const Text('Se déconnecter', style: TextStyle(fontSize: 16)),
                            )
                          : Row(
                              children: [
                                _navItem(context, 'Connexion', '/login'),
                                _navItem(context, 'Créer un compte', '/register'),
                              ],
                            ),
                    ],
                  );
                },
              ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: !isDesktop
            ? [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ]
            : null,
      ),

      endDrawer: !isDesktop
          ? Drawer(
              child: FutureBuilder<bool>(
                future: _isAuthenticated(),
                builder: (context, snapshot) {
                  final isLoggedIn = snapshot.data ?? false;
                  return ListView(
                    children: [
                      InkWell(
                        onTap: () => _navigateTo(context, "/"),
                        child: Image.asset('images/logo_ohmytag.png', width: 100),
                      ),
                      _drawerItem(context, 'Accueil', '/'),
                      if (isLoggedIn) _drawerItem(context, 'Scanner', '/scanner'),
                      if (isLoggedIn) _drawerItem(context, 'Wishlist', '/wishlist'),
                      _drawerItem(context, 'Contact', '/contact'),
                      isLoggedIn
                          ? ListTile(
                              title: const Text('Se déconnecter'),
                              onTap: () => _logout(context),
                            )
                          : Column(
                              children: [
                                _drawerItem(context, 'Connexion', '/login'),
                                _drawerItem(context, 'Créer un compte', '/register'),
                              ],
                            ),
                    ],
                  );
                },
              ),
            )
          : null,

      body: body,
    );
  }

  Widget _navItem(BuildContext context, String title, String route) {
    return TextButton(
      onPressed: () => _navigateTo(context, route),
      style: TextButton.styleFrom(foregroundColor: Colors.black),
      child: Text(title, style: const TextStyle(fontSize: 16, decoration: TextDecoration.none)),
    );
  }

  Widget _drawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      onTap: () => _navigateTo(context, route),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    if (route == '/scanner') {
      Navigator.pushNamed(context, route);
    } else {
      Navigator.pushReplacementNamed(context, route);
    }
  }
}