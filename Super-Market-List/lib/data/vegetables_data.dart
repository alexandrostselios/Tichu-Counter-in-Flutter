import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';


class Vegetable {
  final String name;
  final String unit;
  final AssetImage? image;
  final IconData? icon;

  Vegetable({
    required this.name,
    required this.unit,
    required this.image,
    required this.icon
  });
}

List<Vegetable> getVegetables(BuildContext context) {
  final localization = AppLocalizations.of(context)!; // Get the localization instance

  List<Vegetable> vegetablesList = [];

  try {
    vegetablesList = [
      Vegetable(name: localization.vegetableNames['cucumber']!,icon: null, image: AssetImage('assets/images/vegetables/cucumber.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['tomato']!, icon: null, image: AssetImage('assets/images/vegetables/tomato.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['carrot']!, icon: null, image: AssetImage('assets/images/vegetables/carrot.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['potato']!, icon: null, image: AssetImage('assets/images/vegetables/potato.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['lettuce']!, icon: null, image: AssetImage('assets/images/vegetables/lettuce.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['melon']!, icon: null, image: AssetImage('assets/images/vegetables/melon.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['watermelon']!, icon: null, image: AssetImage('assets/images/vegetables/water-melon.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['orange']!, icon: null, image: AssetImage('assets/images/vegetables/orange.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['broccoli']!, icon: null, image: AssetImage('assets/images/vegetables/broccoli.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['spinach']!, icon: null, image: AssetImage('assets/images/vegetables/spinach.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['bell_pepper']!, icon: null, image: AssetImage('assets/images/vegetables/bell-pepper.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['zucchini']!, icon: null, image: AssetImage('assets/images/vegetables/zucchini.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['cabbage']!, icon: null, image: AssetImage('assets/images/vegetables/cabbage.png'), unit: 'pieces'),
      // Vegetable(name: localization.vegetableNames['beetroot']!, icon: Icons.spa, unit: 'kg'),
      Vegetable(name: localization.vegetableNames['eggplant']!, icon: null, image: AssetImage('assets/images/vegetables/eggplant.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['radish']!, icon: null, image: AssetImage('assets/images/vegetables/radish.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['cauliflower']!, icon: null, image: AssetImage('assets/images/vegetables/cauliflower.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['peas']!, icon: null, image: AssetImage('assets/images/vegetables/peas.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['asparagus']!, icon: null, image: AssetImage('assets/images/vegetables/asparagus.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['artichoke']!, icon: null, image: AssetImage('assets/images/vegetables/artichoke.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['onion']!, icon: null, image: AssetImage('assets/images/vegetables/onion.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['mushroom']!, icon: null, image: AssetImage('assets/images/vegetables/mushrooms.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['garlic']!, icon: null, image: AssetImage('assets/images/vegetables/garlic.png'), unit: 'pieces'),
      Vegetable(name: localization.vegetableNames['lemon']!, icon: null, image: AssetImage('assets/images/vegetables/lemon.png'), unit: 'kg'),
      Vegetable(name: localization.vegetableNames['lime']!, icon: null, image: AssetImage('assets/images/vegetables/lime.png'), unit: 'kg'),
      // Add more vegetables here
    ];
  } catch (e) {
    // Handle the error gracefully, e.g., log the error
    print("Error retrieving vegetables: $e");
  }

  return vegetablesList;
}