import 'package:flutter/cupertino.dart';

class Hygiene {
  final String name;
  final IconData icon;
  final String unit; // "pieces", "bottles", etc.

  Hygiene({required this.name, required this.icon, required this.unit});
}