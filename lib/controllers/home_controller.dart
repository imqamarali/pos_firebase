import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

class HomeController extends ChangeNotifier {
  int currentIndex = 0;
  int cartCount = 0;

  final List<Product> products = [
    Product(
      name: "Wireless Headphones",
      price: 49.99,
      image: "https://images.unsplash.com/photo-1585386959984-a4155224a1ad",
    ),
    Product(
      name: "Smart Watch",
      price: 79.99,
      image: "https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b",
    ),
    Product(
      name: "Gaming Mouse",
      price: 29.99,
      image: "https://images.unsplash.com/photo-1585386959984-a4155224a1ad",
    ),
    Product(
      name: "Bluetooth Speaker",
      price: 39.99,
      image: "https://images.unsplash.com/photo-1585386959984-a4155224a1ad",
    ),
    Product(
      name: "Laptop Stand",
      price: 24.99,
      image: "https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04",
    ),
  ];

  void changeTab(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void addToCart() {
    cartCount++;
    notifyListeners();
  }

  void resetCart() {
    cartCount = 0;
    notifyListeners();
  }
}
