// lib/models/vegetable.dart

import 'package:flutter/material.dart';

class Vegetable {
  final String name;
  final IconData icon;
  final String unit; // "pieces" or "kg"

  Vegetable({required this.name, required this.icon, required this.unit});
}
