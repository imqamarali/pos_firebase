import 'package:flutter/material.dart';

import '../../controllers/home_controller.dart';

class CartTab extends StatelessWidget {
  final HomeController controller;

  const CartTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.cartCount == 0
          ? const Text("Your cart is empty")
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Items in Cart: ${controller.cartCount}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.resetCart,
                  child: const Text("Clear Cart"),
                ),
              ],
            ),
    );
  }
}
