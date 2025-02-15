import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class Hygiene {
  final String name;
  final IconData? icon;
  final String unit; // "pieces", "bottles", etc.
  final AssetImage image;

  Hygiene({
    required this.name,
    required this.icon,
    required this.unit,
    required this.image
  });
}

List<Hygiene> getHygieneProducts(BuildContext context) {
  final localization = AppLocalizations.of(context)!; // Get the localization instance

  List<Hygiene> hygieneProductsList = [];

  try {
    hygieneProductsList = [
      Hygiene(name: localization.hygieneProductNames['Soap']!, icon: null, image: AssetImage('assets/images/hygiene/soap.png'), unit: 'pieces'),
      Hygiene(name: localization.hygieneProductNames['Shampoo']!, icon: null, image: AssetImage('assets/images/hygiene/shampoo.png'), unit: 'kg'),
      Hygiene(name: localization.hygieneProductNames['Toothpaste']!, icon: null, image: AssetImage('assets/images/hygiene/toothpaste.png'), unit: 'kg'),
      Hygiene(name: localization.hygieneProductNames['Tissue_Paper']!, icon: null, image: AssetImage('assets/images/hygiene/toilet-paper.png'), unit: 'kg'),
      // Hygiene(name: localization.hygieneProductNames['Tissue_Paper_2']!, icon: Icons.local_dining, unit: 'kg'),
      // Hygiene(name: localization.hygieneProductNames['Tissue_Paper_3']!, icon: Icons.spa, unit: 'pieces'), // Add more vegetables here
    ];
  } catch (e) {
    // Handle the error gracefully, e.g., log the error
    print("Error retrieving hygiene products: $e");
  }

  return hygieneProductsList;
}

// List of hygiene items
// final List<Hygiene> hygieneItems = [
//   Hygiene(name: 'Soap', icon: Icons.soap, unit: 'pieces'),
//   Hygiene(name: 'Shampoo', icon: Icons.shower, unit: 'bottles'),
//   Hygiene(name: 'Toothpaste', icon: Icons.brush, unit: 'tubes'),
//   Hygiene(name: 'Tissue Paper', icon: Icons.cleaning_services, unit: 'tubes'),
//   Hygiene(name: 'Tissue Paper 2', icon: Icons.cleaning_services, unit: 'packs'),
//   Hygiene(name: 'Tissue Paper 3', icon: Icons.cleaning_services, unit: 'packs'),
// ];