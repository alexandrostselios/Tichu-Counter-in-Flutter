// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `New`
  String get newGame {
    return Intl.message(
      'New',
      name: 'newGame',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Greek`
  String get greek {
    return Intl.message(
      'Greek',
      name: 'greek',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `App Version: `
  String get appVersion {
    return Intl.message(
      'App Version: ',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `My Lists`
  String get myLists {
    return Intl.message(
      'My Lists',
      name: 'myLists',
      desc: '',
      args: [],
    );
  }

  /// `Add new List`
  String get addNewList {
    return Intl.message(
      'Add new List',
      name: 'addNewList',
      desc: '',
      args: [],
    );
  }

  /// `Archieved`
  String get archieved {
    return Intl.message(
      'Archieved',
      name: 'archieved',
      desc: '',
      args: [],
    );
  }

  /// `Archieved`
  String get setAsArchieved {
    return Intl.message(
      'Archieved',
      name: 'setAsArchieved',
      desc: '',
      args: [],
    );
  }

  /// `Non Archieved`
  String get setAsNotArchieved {
    return Intl.message(
      'Non Archieved',
      name: 'setAsNotArchieved',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Set List Description`
  String get setListName {
    return Intl.message(
      'Set List Description',
      name: 'setListName',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePage {
    return Intl.message(
      'Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Enter List Name`
  String get enterListName {
    return Intl.message(
      'Enter List Name',
      name: 'enterListName',
      desc: '',
      args: [],
    );
  }

  /// `e.g., Grocery List`
  String get listNameExample {
    return Intl.message(
      'e.g., Grocery List',
      name: 'listNameExample',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Vegetables`
  String get vegetables {
    return Intl.message(
      'Vegetables',
      name: 'vegetables',
      desc: '',
      args: [],
    );
  }

  /// `Hygiene Products`
  String get hygieneProducts {
    return Intl.message(
      'Hygiene Products',
      name: 'hygieneProducts',
      desc: '',
      args: [],
    );
  }

  /// `Milk Products`
  String get milkProducts {
    return Intl.message(
      'Milk Products',
      name: 'milkProducts',
      desc: '',
      args: [],
    );
  }

  /// `Chicken Products`
  String get chickenProducts {
    return Intl.message(
      'Chicken Products',
      name: 'chickenProducts',
      desc: '',
      args: [],
    );
  }

  /// `Cow Products`
  String get cowProducts {
    return Intl.message(
      'Cow Products',
      name: 'cowProducts',
      desc: '',
      args: [],
    );
  }

  /// `Pork Products`
  String get porkProducts {
    return Intl.message(
      'Pork Products',
      name: 'porkProducts',
      desc: '',
      args: [],
    );
  }

  /// `Products Categories`
  String get productsCategories {
    return Intl.message(
      'Products Categories',
      name: 'productsCategories',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this list `
  String get confirmDeleteInfo {
    return Intl.message(
      'Are you sure you want to delete this list ',
      name: 'confirmDeleteInfo',
      desc: '',
      args: [],
    );
  }

  /// `?`
  String get questionMark {
    return Intl.message(
      '?',
      name: 'questionMark',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Archieve`
  String get confirmArchieve {
    return Intl.message(
      'Confirm Archieve',
      name: 'confirmArchieve',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to archieve this list `
  String get confirmArchieveInfo {
    return Intl.message(
      'Are you sure you want to archieve this list ',
      name: 'confirmArchieveInfo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Active`
  String get confirmActive {
    return Intl.message(
      'Confirm Active',
      name: 'confirmActive',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to set as active this list `
  String get confirmActiveInfo {
    return Intl.message(
      'Are you sure you want to set as active this list ',
      name: 'confirmActiveInfo',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get shoppingCart {
    return Intl.message(
      'My Cart',
      name: 'shoppingCart',
      desc: '',
      args: [],
    );
  }

  /// `Your shopping cart is empty.`
  String get emptyShoppingCartInfo {
    return Intl.message(
      'Your shopping cart is empty.',
      name: 'emptyShoppingCartInfo',
      desc: '',
      args: [],
    );
  }

  /// `Quantity:`
  String get quantity {
    return Intl.message(
      'Quantity:',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cart no empty`
  String get cartNoEmpty {
    return Intl.message(
      'Cart no empty',
      name: 'cartNoEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Enter quantity in`
  String get enterQuantityIn {
    return Intl.message(
      'Enter quantity in',
      name: 'enterQuantityIn',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'el'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
