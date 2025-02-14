import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:super_market_list/models/CarManufacter.dart';
import 'package:super_market_list/pages/archive_page.dart';
import 'package:super_market_list/pages/help_page.dart';
import 'package:super_market_list/pages/home_page.dart';
import 'package:super_market_list/pages/language_selection_page.dart';
import 'package:super_market_list/pages/myListsPage.dart';
import 'package:super_market_list/pages/listItemsPage.dart';
import 'package:provider/provider.dart';
import 'package:super_market_list/pages/locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'list_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _saveList(BuildContext context) async {
    // Create an instance of ListManager
    ListManager listManager = ListManager();

    // Call saveXML with the current context
    await listManager.saveXML(context, "MAIN DART", []);
  }

  @override
  Widget build(BuildContext context) {
    // This callback runs after the build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveList(context);
    });
    return Consumer<LocaleProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'Super Market List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Super Market List'),
          locale: languageProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('el', ''),
          ],
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _selectedValue = '';
  final String _appVersion = '';
  List<Map<String, dynamic>> itemsTable = []; // Move itemsTable here
  late ListManager _listManager = ListManager();

  void onSave(String listName) {
    // Save logic here
    print('List saved: $listName');
  }
  // Widget options for navigation
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MyListsPage(),
    ArchivedPage(),
    ListItemsPage(onSave: _MyHomePageState().onSave, itemsTable: _MyHomePageState().itemsTable),
  ];

  void _onItemTapped(int index) {
    print("Index: $index");
    //fetchUsers();
    setState(() {
      _selectedIndex = index;
      if (index == 1) { // If navigating to MyListsPage
        itemsTable.clear(); // Clear the itemsTable
      }
    });
  }

  Future<void> _loadShoppingLists() async {
    await _listManager.loadActiveShoppingLists(); // Load lists from XML
    print("======================== Load Shopping Lists ========================");
    setState(() {}); // Rebuild the UI after loading
  }

  void _handleMenuSelection(String value) {
    setState(() {
      _selectedValue = value;
    });

    if (value == 'New') {
      print("NEW CLICKED ================================== ");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListItemsPage(
            onSave: (String listName) {
              _onNewListSaved(listName);
              // Call the function to go back to the main layout
              Navigator.of(context).pop(); // Pop the ListItemsPage
            },
            itemsTable: [],
          ),
        ),
      ).then((_) async {
        // Reload shopping lists after popping ListItemsPage
        await _loadShoppingLists();

        // Update the index to show MyListsPage
        setState(() {
          _selectedIndex = 1; // Assuming MyListsPage is at index 1
        });
      });
    } else if (value == 'Save') {
      // Handle save logic
    } else if (value == 'Help') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HelpPage()),
      );
    } else if (value == 'About') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('${AppLocalizations.of(context)!.appVersion} $_appVersion'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _onNewListSaved(String listName) {
    // Handle the newly saved list here (optional logic)
    print('New List Saved: $listName');
  }

  //Test API Call
  // Future<List<dynamic>> fetchUsers() async {
  //   print("Fetch Called");
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://garagewebapi.eu/api/GetCarManufacturers'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print("API Request Sent");
  //     if (response.statusCode == 200) {
  //       // Parse the JSON response
  //       final List<dynamic> jsonList = json.decode(response.body);
  //       //print("Response Received: ${response.body}");
  //       //return json.decode(response.body); // Parse JSON data
  //       // Store parsed items in a list
  //       List<Carmanufacter> carManufacturers = jsonList.map((jsonItem) {
  //         return Carmanufacter.fromJson(jsonItem);
  //       }).toList();
  //
  //       print("Fetched and stored data: $carManufacturers");
  //       return carManufacturers;
  //     } else {
  //       print("API Error: Status Code ${response.statusCode}");
  //       throw Exception('Failed to load users');
  //     }
  //   } catch (e) {
  //     print("Error during fetchUsers: $e");
  //     throw e;
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple[100],
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.menu_open_rounded,
                size: 48,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.new_label_rounded),
              title: Text(AppLocalizations.of(context)!.newGame),
              onTap: () => _handleMenuSelection("New"),
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: Text(AppLocalizations.of(context)!.save),
              onTap: () => _handleMenuSelection("Save"),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(AppLocalizations.of(context)!.help),
              onTap: () => _handleMenuSelection("Help"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.of(context)!.Language),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(AppLocalizations.of(context)!.about),
              onTap: () => _handleMenuSelection("About"),
            ),
          ],
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure all items are shown without "shifting" behavior
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(icon: const Icon(Icons.list), label: AppLocalizations.of(context)!.myLists),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: AppLocalizations.of(context)!.archieved),
          BottomNavigationBarItem(icon: Image.asset('assets/images/categories/app.png', width: 24,height: 24,), label: AppLocalizations.of(context)!.categories),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[800],
        selectedLabelStyle: TextStyle(fontSize: 14), // Font size for the selected label
        unselectedLabelStyle: TextStyle(fontSize: 12), // Font size for unselected labels
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ListItemsPage(
                onSave: (String listName) {
                  _onNewListSaved(listName); // Handle saving the list name
                },
                itemsTable: itemsTable, // Pass itemsTable here
              ),
            ),
          ).then((_) {
            setState(() {
              // Optionally refresh state or do nothing
            });
          });
        },
        tooltip: 'Add New List',
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}
