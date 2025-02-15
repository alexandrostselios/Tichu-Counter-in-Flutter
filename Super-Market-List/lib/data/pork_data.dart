import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';


class Pork {
  final String name;
  final String unit;
  final AssetImage? image;
  final IconData? icon;

  Pork({
    required this.name,
    required this.unit,
    required this.image,
    required this.icon
  });
}

List<Pork> getPorkProducts(BuildContext context) {
  final localization = AppLocalizations.of(context)!; // Get the localization instance

  List<Pork> porkList = [];

  try {
    porkList = [
      Pork(name: localization.porkNames['minced_pork']!,icon: null, image: AssetImage('assets/images/pork/minced-meat.png'), unit: 'kg'),
      Pork(name: localization.porkNames['fillet']!, icon: null, image: AssetImage('assets/images/pork/fillet.png'), unit: 'kg'),
      Pork(name: localization.porkNames['bacon']!, icon: null, image: AssetImage('assets/images/pork/bacon.png'), unit: 'kg'),
      Pork(name: localization.porkNames['steak']!, icon: null, image: AssetImage('assets/images/pork/steak.png'), unit: 'kg'),
      Pork(name: localization.porkNames['sausage']!, icon: null, image: AssetImage('assets/images/pork/sausage.png'), unit: 'kg'),
      Pork(name: localization.porkNames['ham']!, icon: null, image: AssetImage('assets/images/pork/ham.png'), unit: 'kg'),
    ];
  } catch (e) {
    // Handle the error gracefully, e.g., log the error
    print("Error retrieving pork: $e");
  }

  return porkList;
}