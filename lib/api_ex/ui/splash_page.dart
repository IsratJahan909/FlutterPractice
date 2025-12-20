import 'package:flutter/material.dart';
import 'package:ay_app/api_ex/services/auth_service.dart';
import 'package:ay_app/api_ex/ui/login_page.dart';
import 'package:ay_app/api_ex/ui/product_list_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    final token = await authService.getToken();

    // if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // User already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductListPage()),
      );
    } else {
      // Not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
