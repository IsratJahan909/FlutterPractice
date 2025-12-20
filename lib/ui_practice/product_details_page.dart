import 'package:flutter/material.dart';
import '../api_ex/models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.imageUrl!, height: 220),
            ),
            const SizedBox(height: 15),
            Text(product.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(product.category,
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Text("\$${product.price}",
                style:
                    const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 10),
            Text(product.description!),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Add to Cart"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
