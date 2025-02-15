import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';


class Chicken {
  final String name;
  final String unit;
  final AssetImage? image;
  final IconData? icon;

  Chicken({
    required this.name,
    required this.unit,
    required this.image,
    required this.icon
  });
}

List<Chicken> getChickenProducts(BuildContext context) {
  final localization = AppLocalizations.of(context)!; // Get the localization instance

  List<Chicken> chickenList = [];

  try {
    chickenList = [
      Chicken(name: localization.chickenNames['breast']!,icon: null, image: AssetImage('assets/images/chicken/chicken-breast.png'), unit: 'kg'),
      Chicken(name: localization.chickenNames['foot']!, icon: null, image: AssetImage('assets/images/chicken/chicken-leg.png'), unit: 'kg'),
      Chicken(name: localization.chickenNames['nuggets']!, icon: null, image: AssetImage('assets/images/chicken/nuggets.png'), unit: 'kg'),
      // Add more vegetables here
    ];
  } catch (e) {
    // Handle the error gracefully, e.g., log the error
    print("Error retrieving chicken: $e");
  }

  return chickenList;
}