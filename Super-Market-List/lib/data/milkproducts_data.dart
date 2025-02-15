import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class Milk {
  final String name;
  final IconData? icon;
  final String unit;
  final AssetImage image;

  Milk( {
    required this.name,
    required this.icon,
    required this.unit,
    required this.image
  });
}

List<Milk> getMilkProducts(BuildContext context) {
  final localization = AppLocalizations.of(context)!; // Get the localization instance

  List<Milk> milkProductsList = [];

  try {
    milkProductsList = [
      Milk(name: localization.milkProductNames['Milk_5%']!, icon: null, image: AssetImage('assets/images/milk/milk-0%.png'), unit: 'pieces'),
      Milk(name: localization.milkProductNames['Milk_2%']!, icon: null, image: AssetImage('assets/images/milk/milk-1.5%.png'), unit: 'kg'),
      Milk(name: localization.milkProductNames['Milk_0%']!, icon: null, image: AssetImage('assets/images/milk/milk-0%.png'), unit: 'kg'),
      Milk(name: localization.milkProductNames['Milk']!, icon: null, image: AssetImage('assets/images/milk/milk-full.png'), unit: 'kg'),
      Milk(name: localization.milkProductNames['Chocolate_Milk']!, icon: null, image: AssetImage('assets/images/milk/chocolate-milk.png'), unit: 'kg'),
      // MilkProduct(name: localization.milkProductNames['Milk_2']!, icon: Icons.spa, unit: 'pieces'),
      // MilkProduct(name: localization.milkProductNames['Milk_3']!, icon: Icons.spa, unit: 'pieces'), // Add more vegetables here
      // MilkProduct(name: localization.milkProductNames['Milk_4']!, icon: Icons.spa, unit: 'pieces'), // Add more vegetables here
    ];
  } catch (e) {
    // Handle the error gracefully, e.g., log the error
    print("Error retrieving milk products: $e");
  }

  return milkProductsList;
}

// List of milk items
// final List<MilkProduct> milkItems = [
//   MilkProduct(name: 'Milk 5%', icon: Icons.soap, unit: 'bottles'),
//   MilkProduct(name: 'Milk 2%', icon: Icons.shower, unit: 'bottles'),
//   MilkProduct(name: 'Milk 0%', icon: Icons.brush, unit: 'bottles'),
//   MilkProduct(name: 'Milk', icon: Icons.cleaning_services, unit: 'bottles'),
//   MilkProduct(name: 'Chocolate Milk', icon: Icons.spa, unit: 'bottles'),
//   MilkProduct(name: 'Milk 2', icon: Icons.spa, unit: 'bottles'),
//   MilkProduct(name: 'Milk 3', icon: Icons.spa, unit: 'bottles'),
//   MilkProduct(name: 'Milk 4', icon: Icons.spa, unit: 'bottles'),
// ];