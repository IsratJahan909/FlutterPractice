import 'package:ay_app/crus_SQLite/screens/user_form.dart';
import 'package:ay_app/crus_SQLite/screens/user_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const UserList(),
      routes: {
        "/": (context) => UserList(),
        "/form": (context) => UserForm(),
      },
    );
  }
}
