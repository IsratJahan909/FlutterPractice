import 'package:ay_app/ui_practice/demo_data.dart';
import 'package:ay_app/ui_practice/product_details_page.dart';
import 'package:flutter/material.dart';
import '../api_ex/models/product.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    List<Product> results = demoProducts
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Search Products")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final product = results[index];
                return ListTile(
                  leading: Image.network(product.imageUrl!, width: 50),
                  title: Text(product.name),
                  subtitle: Text(product.category),
                  trailing: Text("\$${product.price}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailsPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
