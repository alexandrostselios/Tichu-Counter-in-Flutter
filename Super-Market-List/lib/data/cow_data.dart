import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';


class Cow {
  final String name;
  final String unit;
  final AssetImage? image;
  final IconData? icon;

  Cow({
    required this.name,
    required this.unit,
    required this.image,
    required this.icon
  });
}

List<Cow> getCowProducts(BuildContext context) {
  final localization = AppLocalizations.of(context)!; // Get the localization instance

  List<Cow> cowList = [];

  try {
    cowList = [
      Cow(name: localization.cowNames['minced_beef']!,icon: null, image: AssetImage('assets/images/cow/minced-meat.png'), unit: 'kg'),
      Cow(name: localization.cowNames['steak']!, icon: null, image: AssetImage('assets/images/cow/steak.png'), unit: 'kg'),
      // Add more vegetables here
    ];
  } catch (e) {
    // Handle the error gracefully, e.g., log the error
    print("Error retrieving cow: $e");
  }

  return cowList;
}