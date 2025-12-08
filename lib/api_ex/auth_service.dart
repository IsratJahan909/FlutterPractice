// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://192.168.20.20:8080/api/auth";

  /// Login with username & password
  /// Returns true if login successful
  Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/signin"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final token = data['jwtToken'];

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', token); // save token
        return true;
      }
    }

    return false;
  }

  /// Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
  }

  /// Get saved JWT
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }
}
