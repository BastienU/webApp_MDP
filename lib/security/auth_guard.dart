import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../views/login.dart';

class AuthGuard extends StatelessWidget {
  final Widget protectedPage;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  const AuthGuard({super.key, required this.protectedPage});

  Future<bool> _isAuthenticated() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isAuthenticated(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data == true ? protectedPage : const LoginPage();
      },
    );
  }
}