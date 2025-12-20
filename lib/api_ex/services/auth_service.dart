// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "https://rander-secqurity-3.onrender.com/api/auth";

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



  /// Build headers for HTTP requests
  Future<Map<String, String>> headers({bool auth = false}) async {
    final token = await getToken();
      // final headers = await AuthService.getAuthHeaders();

    if (auth && (token == null || token.isEmpty)) {
      throw Exception("No JWT token found. Please login first.");
    }

    final headers = {
      "Content-Type": "application/json",
      if (auth) "Authorization": "Bearer $token",
    };

    print("==== HTTP Headers ====");
    headers.forEach((k, v) => print("$k: $v"));
    print("=====================");

    return headers;
  }

    // Get authorization headers for API calls
  // static Future<Map<String, String>> getAuthHeaders() async {
  //   final token = await getToken();
  //   return {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  // }
}
