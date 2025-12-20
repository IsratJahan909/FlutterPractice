import 'package:ay_app/ui_practice/demo_data.dart';
import 'package:ay_app/ui_practice/product_details_page.dart';
import 'package:flutter/material.dart';
import '../api_ex/models/product.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = demoProducts
        .where((p) => p.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filteredProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsPage(product: product),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(product.imageUrl!, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text("\$${product.price}",
                            style: const TextStyle(color: Colors.blue)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
