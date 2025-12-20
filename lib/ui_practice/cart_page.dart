import 'package:ay_app/ui_practice/demo_data.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double total =
        demoProducts.fold(0, (sum, p) => sum + p.price);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: demoProducts.length,
              itemBuilder: (context, index) {
                final product = demoProducts[index];
                return ListTile(
                  leading:
                      Image.network(product.imageUrl!, width: 50),
                  title: Text(product.name),
                  trailing: Text("\$${product.price}"),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(fontSize: 18)),
                    Text("\$${total.toStringAsFixed(2)}",
                        style:
                            const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Checkout"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
