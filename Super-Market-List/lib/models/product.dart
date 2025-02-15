import 'package:flutter/material.dart';

class Product {
  final String name;
  final IconData icon; // Common to both vegetables and hygiene
  final String unit; // e.g., "pieces", "kg", "bottle", "pack"

  Product({
    required this.name,
    required this.icon,
    required this.unit,
  });
}
