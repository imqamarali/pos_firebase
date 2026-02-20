import 'package:flutter/material.dart';

import '../../controllers/home_controller.dart';

class HomeTab extends StatelessWidget {
  final HomeController controller;

  const HomeTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = controller.products[index];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.addToCart,
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
