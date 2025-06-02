import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/login.dart';

class AuthGuard extends StatelessWidget {
  final Widget protectedPage;

  const AuthGuard({super.key, required this.protectedPage});

  Future<bool> _isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
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