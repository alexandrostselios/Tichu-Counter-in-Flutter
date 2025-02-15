import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../generated/intl/messages_all.dart';
// import 'intl/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : '${locale.languageCode}_${locale.countryCode}';
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return AppLocalizations(locale);
    });
  }

  String get newGame {
    return Intl.message(
      'New Game',
      name: 'newGame',
      desc: 'The label for the New menu item',
      locale: locale.toString(),
    );
  }

  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'The label for the Save menu item',
      locale: locale.toString(),
    );
  }

  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: 'The label for the Help menu item',
      locale: locale.toString(),
    );
  }

  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: 'The label for the About menu item',
      locale: locale.toString(),
    );
  }

  String get Language {
    return Intl.message(
      'language',
      name: 'Language',
      desc: 'The label for the Language menu item',
      locale: locale.toString(),
    );
  }

  String get selectLanguage {
    return Intl.message(
      'SelectLanguage',
      name: 'selectLanguage',
      desc: 'The label for the Select Language menu item',
      locale: locale.toString(),
    );
  }

  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: 'The label for the English menu item',
      locale: locale.toString(),
    );
  }

  String get greek {
    return Intl.message(
      'Greek',
      name: 'greek',
      desc: 'The label for the Greek menu item',
      locale: locale.toString(),
    );
  }

  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: 'The label for the Submit menu item',
      locale: locale.toString(),
    );
  }

  String get appVersion {
    return Intl.message(
      'App Version',
      name: 'appVersion',
      desc: 'App Version',
      locale: locale.toString(),
    );
  }

  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Home',
      locale: locale.toString(),
    );
  }

  String get myLists {
    return Intl.message(
      'My Lists',
      name: 'myLists',
      desc: 'My Lists',
      locale: locale.toString(),
    );
  }

  String get addNewList {
    return Intl.message(
      'Add new List',
      name: 'addNewList',
      desc: 'Add new List',
      locale: locale.toString(),
    );
  }

  String get archieved {
    return Intl.message(
      'Archieved',
      name: 'archieved',
      desc: 'Archieved',
      locale: locale.toString(),
    );
  }

  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: 'Add',
      locale: locale.toString(),
    );
  }

  String get setListName {
    return Intl.message(
      'Set List Name',
      name: 'setListName',
      desc: 'Set List Name',
      locale: locale.toString(),
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel',
      locale: locale.toString(),
    );
  }

  String get homePage {
    return Intl.message(
      'Ηome Page',
      name: 'homePage',
      desc: 'Ηome Page',
      locale: locale.toString(),
    );
  }

  String get productsCategories {
    return Intl.message(
      'Products Categories',
      name: 'productsCategories',
      desc: 'Products Categories',
      locale: locale.toString(),
    );
  }

  String get enterListName {
    return Intl.message(
      'Enter List Name',
      name: 'enterListName',
      desc: 'Enter List Name',
      locale: locale.toString(),
    );
  }

  String get listNameExample {
    return Intl.message(
      'List Name Example',
      name: 'listNameExample',
      desc: 'List Name Example',
      locale: locale.toString(),
    );
  }

  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: 'Close',
      locale: locale.toString(),
    );
  }

  String get setAsArchieved{
    return Intl.message(
      'Set AS Archieved',
      name: 'setAsArchieved',
      desc: 'Set AS Archieved',
      locale: locale.toString(),
    );
  }

  String get setAsNotArchieved{
    return Intl.message(
      'Set AS Not Archieved',
      name: 'setAsNotArchieved',
      desc: 'Set AS Not Archieved',
      locale: locale.toString(),
    );
  }

  String get vegetables{
    return Intl.message(
      'Vegetables',
      name: 'vegetables',
      desc: 'vegetables',
      locale: locale.toString(),
    );
  }

  String get hygieneProducts{
    return Intl.message(
      'Hygiene Products',
      name: 'hygieneProducts',
      desc: 'Hygiene Products',
      locale: locale.toString(),
    );
  }

  String get milkProducts{
    return Intl.message(
      'Milk Products',
      name: 'milkProducts',
      desc: 'Milk Products',
      locale: locale.toString(),
    );
  }

  String get chickenProducts{
    return Intl.message(
      'Chicken Products',
      name: 'chickenProducts',
      desc: 'Chicken Products',
      locale: locale.toString(),
    );
  }

  String get cowProducts{
    return Intl.message(
      'Cow Products',
      name: 'cowProducts',
      desc: 'Cow Products',
      locale: locale.toString(),
    );
  }

  String get porkProducts{
    return Intl.message(
      'Pork Products',
      name: 'porkProducts',
      desc: 'Pork Products',
      locale: locale.toString(),
    );
  }

  String get delete{
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'Delete',
      locale: locale.toString(),
    );
  }

  String get confirmDelete{
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: 'Confirm Delete',
      locale: locale.toString(),
    );
  }

  String get confirmDeleteInfo{
    return Intl.message(
      'Confirm Delete Info',
      name: 'confirmDeleteInfo',
      desc: 'Confirm Delete Info',
      locale: locale.toString(),
    );
  }

  String get confirmArchieve{
    return Intl.message(
      'Confirm Archieve',
      name: 'confirmArchieve',
      desc: 'Confirm Archieve',
      locale: locale.toString(),
    );
  }

  String get confirmArchieveInfo{
    return Intl.message(
      'Confirm Archieve Info',
      name: 'confirmArchieveInfo',
      desc: 'Confirm Archieve Info',
      locale: locale.toString(),
    );
  }

  String get questionMark{
    return Intl.message(
      'Question Mark',
      name: 'questionMark',
      desc: 'Question Mark',
      locale: locale.toString(),
    );
  }

  String get confirmActive{
    return Intl.message(
      'Confirm Active',
      name: 'confirmActive',
      desc: 'Confirm Active',
      locale: locale.toString(),
    );
  }

  String get confirmActiveInfo{
    return Intl.message(
      'Confirm Active Info',
      name: 'confirmActiveInfo',
      desc: 'Confirm Active Info',
      locale: locale.toString(),
    );
  }

  String get emptyShoppingCartInfo{
    return Intl.message(
      'Empty Shopping Cart Info',
      name: 'emptyShoppingCartInfo',
      desc: 'Empty Shopping Cart Info',
      locale: locale.toString(),
    );
  }

  String get shoppingCart{
    return Intl.message(
      'Shopping Cart',
      name: 'shoppingCart',
      desc: 'Shopping Cart',
      locale: locale.toString(),
    );
  }

  String get quantity{
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: 'Quantity',
      locale: locale.toString(),
    );
  }

  String get confirm{
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: 'Confirm',
      locale: locale.toString(),
    );
  }

  String get cartNoEmpty{
    return Intl.message(
      'Cart no empty',
      name: 'cartNoEmpty',
      desc: 'Cart no empty',
      locale: locale.toString(),
    );
  }

  String get search{
    return Intl.message(
      'Search',
      name: 'search',
      desc: 'Search',
      locale: locale.toString(),
    );
  }

  String get enterQuantityIn{
    return Intl.message(
      'Enter quantity in',
      name: 'enterQuantityIn',
      desc: 'Enter quantity in',
      locale: locale.toString(),
    );
  }

  String get category{
    return Intl.message(
      'category',
      name: 'category',
      desc: 'Category',
      locale: locale.toString(),
    );
  }

  String get categories{
    return Intl.message(
      'categories',
      name: 'categories',
      desc: 'Categories',
      locale: locale.toString(),
    );
  }

  // Method to get vegetables map
  Map<String, String> get vegetableNames {
    switch (locale.languageCode) {
      case 'el': // Greek
        return {
          'cucumber': 'Αγγούρι',
          'tomato': 'Ντομάτα',
          'carrot': 'Καρότο',
          'potato': 'Πατάτα',
          'lettuce': 'Μαρούλι',
          'melon': 'Πεπόνι',
          'watermelon': 'Καρπούζι',
          'orange': 'Πορτοκάλι',
          'broccoli': 'Μπρόκολο',
          'spinach': 'Σπανάκι',
          'bell_pepper': 'Πιπεριά',
          'zucchini': 'Κολοκύθι',
          'cabbage': 'Λάχανο',
          'beetroot': 'Τεραίνιο',
          'eggplant': 'Μελιτζάνα',
          'radish': 'Ραπανάκι',
          'cauliflower': 'Κουνουπίδι',
          'peas': 'Μπιζέλια',
          'asparagus': 'Σπαράγγια',
          'artichoke': 'Αγκινάρα',
          'onion': 'Κρεμμύδι',
          'mushroom': 'Μανιτάρια',
          'garlic': 'Σκόρδο',
          'lemon': 'Λεμόνι',
          'lime': 'Λάιμ',
        };
      case 'en': // English
      default: // Fallback to English
        return {
          'cucumber': 'Cucumber',
          'tomato': 'Tomato',
          'carrot': 'Carrot',
          'potato': 'Potato',
          'lettuce': 'Lettuce',
          'melon': 'Melon',
          'watermelon': 'Watermelon',
          'orange': 'Orange',
          'broccoli': 'Broccoli',
          'spinach': 'Spinach',
          'bell_pepper': 'Bell pepper',
          'zucchini': 'Zucchini',
          'cabbage': 'Cabbage',
          'beetroot': 'Beetroot',
          'eggplant': 'Eggplant',
          'radish': 'Radish',
          'cauliflower': 'Cauliflower',
          'peas': 'Peas',
          'asparagus': 'Asparagus',
          'artichoke': 'Artichoke',
          'onion': 'Onion',
          'mushroom': 'Mushroom',
          'garlic': 'Garlic',
          'lemon': 'Lemon',
          'lime': 'Lime',
        };
    }
  }

  // Method to get vegetables map
  Map<String, String> get hygieneProductNames {
    switch (locale.languageCode) {
      case 'el': // Greek
        return {
          'Soap': 'Σαπούνι',
          'Shampoo': 'Αφρόλουτρο',
          'Toothpaste': 'Οδοντόκρεμα',
          'Tissue_Paper': 'Χαρτί Υγείας',
          'Tissue_Paper_2': 'Χαρτί Υγείας 2',
          'Tissue_Paper_3': 'Χαρτί Υγείας 3',
        };
      case 'en': // English
      default: // Fallback to English
        return {
          'Soap': 'Soap',
          'Shampoo': 'Shampoo',
          'Toothpaste': 'Toothpaste',
          'Tissue_Paper': 'Tissue Paper',
          'Tissue_Paper_2': 'Tissue Paper 2',
          'Tissue_Paper_3': 'Tissue Paper 3',
        };
    }
  }

  // Method to get vegetables map
  Map<String, String> get milkProductNames {
    switch (locale.languageCode) {
      case 'el': // Greek
        return {
          'Milk_5%': 'Γάλα 5%',
          'Milk_2%': 'Γάλα 2%',
          'Milk_0%': 'Γάλα 0%',
          'Milk': 'Γάλα Πλήρες',
          'Chocolate_Milk': 'Σοκολατούχο Γάλα',
          'Milk_2': 'Γάλα 2',
          'Milk_3': 'Γάλα 3',
          'Milk_4': 'Γάλα 4',
        };
      case 'en': // English
      default: // Fallback to English
        return {
          'Milk_5%': 'Milk 5%',
          'Milk_2%': 'Milk 2%',
          'Milk_0%': 'Milk 0%',
          'Milk': 'Milk Full',
          'Chocolate_Milk': 'Chocolate Milk',
          'Milk_2': 'Milk 2',
          'Milk_3': 'Milk 3',
          'Milk_4': 'Milk 4',
        };
    }
  }

  // Method to get chicken map
  Map<String, String> get chickenNames {
    switch (locale.languageCode) {
      case 'el': // Greek
        return {
          'breast': 'Στήθος',
          'foot': 'Μπούτι',
          'nuggets': 'Κοτομπουκιές'
        };
      case 'en': // English
      default: // Fallback to English
        return {
          'breast': 'Milk 5%',
          'foot': 'Foot',
          'nuggets': 'Nuggets'
        };
    }
  }

  // Method to get chicken map
  Map<String, String> get cowNames {
    switch (locale.languageCode) {
      case 'el': // Greek
        return {
          'minced_beef': 'Κιμάς',
          'steak': 'Μπριζόλα',
        };
      case 'en': // English
      default: // Fallback to English
        return {
          'minced_beef': 'Minced Beef',
          'steak': 'Steak',
        };
    }
  }

  // Method to get chicken map
  Map<String, String> get porkNames {
    switch (locale.languageCode) {
      case 'el': // Greek
        return {
          'minced_pork': 'Κιμάς',
          'steak': 'Μπριζόλα',
          'bacon': 'Μπέικον',
          'fillet': 'Φιλέτο',
          'ham': 'Ζαμπόν',
          'sausage': 'Λουκάνικο',
        };
      case 'en': // English
      default: // Fallback to English
        return {
          'minced_pork': 'Minced Pork',
          'steak': 'Steak',
          'bacon': 'Bacon',
          'fillet': 'Fillet',
          'ham': 'Ham',
          'sausage': 'Sausage',
        };
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'el'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}