import 'package:ay_app/rout.dart';
import 'package:ay_app/tostEx.dart';
import 'package:ay_app/ui_practice/cart_page.dart';
import 'package:ay_app/ui_practice/search_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Common Bar Demo',
      home: const HomePage(),
    );
  }
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//Common Drawer
class AppDrawer extends StatelessWidget{
  final BuildContext context;
  const AppDrawer({super.key, required this.context});

  void navigate(Widget page) {
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
              accountName: Text("Israt"),
              accountEmail: Text("israt@gmail.com"),
          currentAccountPicture: CircleAvatar(


            backgroundImage: AssetImage("asset/logo.png"),
          ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => navigate(const HomePage()),
          ),

          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text("Message"),
            onTap: () => navigate(const MessageHomePage(),),
          ),

          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Home"),
            onTap: () => navigate(const SearchPage()),
          ),

          ListTile(
            leading: const Icon(Icons.abc_outlined),
            title: const Text("About"),
            onTap: () => navigate(const AboutPage()),
          ),

          ListTile(
            leading: const Icon(Icons.card_travel),
            title: const Text("Cart"),
            onTap: () => navigate(const CartPage()),
          ),

        ],
      ),
    );

  }

}

