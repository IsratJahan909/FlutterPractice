import 'package:ay_app/ui_practice/demo_data.dart';
import 'package:ay_app/ui_practice/product_details_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ShopEasy")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: demoProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final p = demoProducts[index];

          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsPage(product: p),
              ),
            ),
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(p.imageUrl!, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(
                          "\$${p.price}",
                          style: const TextStyle(color: Colors.blue),
                        )
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
