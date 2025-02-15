import 'package:flutter/material.dart';
import 'package:super_market_list/pages/shoopingCartPage.dart';
import '../l10n/app_localizations.dart';
import '../list_manager.dart';
import 'categoryPage.dart';

class ListItemsPage extends StatefulWidget {
  final Function(String) onSave;
  final List<Map<String, dynamic>> itemsTable;

  const ListItemsPage({super.key, required this.onSave, required this.itemsTable});

  @override
  _ListItemsPageState createState() => _ListItemsPageState();
}

class _ListItemsPageState extends State<ListItemsPage> {
  late List<Map<String, dynamic>> itemsTable;
  final ListManager _listManager = ListManager();

  @override
  void initState() {
    super.initState();
    itemsTable = widget.itemsTable;
  }

  Future<bool> _onWillPop() async {
    // Show confirmation dialog if there are items in the cart
    if (itemsTable.isNotEmpty) {
      bool? confirmExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.cartNoEmpty),
          content: Text('You have items in your cart. Are you sure you want to go back?'),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                // Clear the cart only if the user confirms exit
                itemsTable.clear();
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      );
      return confirmExit ?? false;
    }
    // Allow back navigation if the cart is empty
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              // Add your custom image icon on the right side of the AppBar
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 25, // Set desired width
                  height: 25, // Set desired height
                  child: Image.asset('assets/images/categories/app.png'),
                ),
              ),
            ],
            title: Text(AppLocalizations.of(context)!.productsCategories),
          ),
        body: ListView(
          children: <Widget>[
            ListTile(
              //leading: const Icon(Icons.eco),
              leading: const Image(image: AssetImage('assets/images/categories/vegetables.png')),
              title: Text(AppLocalizations.of(context)!.vegetables),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: Category.Vegetables,
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {}); // Refresh UI when returning from CategoryPage
                });
              },
            ),
            const SizedBox(height: 10.0),
            ListTile(
              //leading: const Icon(Icons.soap),
              leading: const Image(image: AssetImage('assets/images/categories/sanitary.png')),
              title: Text(AppLocalizations.of(context)!.hygieneProducts),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: Category.Hygiene,
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
            const SizedBox(height: 10.0),
            ListTile(
              //leading: const Icon(Icons.arrow_back),
              leading: const Image(image: AssetImage('assets/images/categories/dairy.png')),
              title: Text(AppLocalizations.of(context)!.milkProducts),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: Category.MilkProduct,
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
            const SizedBox(height: 10.0),
            ListTile(
              //leading: const Icon(Icons.soap),
              leading: const Image(image: AssetImage('assets/images/categories/chicken.png')),
              title: Text(AppLocalizations.of(context)!.chickenProducts),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: Category.Chicken,
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
            const SizedBox(height: 10.0),
            ListTile(
              //leading: const Icon(Icons.arrow_back),
              leading: const Image(image: AssetImage('assets/images/categories/cow.png')),
              title: Text(AppLocalizations.of(context)!.cowProducts),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: Category.Cow,
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
            const SizedBox(height: 10.0),
            ListTile(
              //leading: const Icon(Icons.arrow_back),
              leading: const Image(image: AssetImage('assets/images/categories/pork.png')),
              title: Text(AppLocalizations.of(context)!.porkProducts),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(
                      category: Category.Pork,
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
          ],
        ),

        floatingActionButton: Stack(
          clipBehavior: Clip.none,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(
                      onSave: (String listName) {
                        // Handle saving if needed
                      },
                      itemsTable: itemsTable,
                    ),
                  ),
                ).then((_) {
                  setState(() {}); // Refresh the badge when returning from ShoppingCartPage
                });
              },
              tooltip: 'View Shopping Cart',
              child: const Icon(Icons.shopping_cart),
            ),
            if (itemsTable.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    itemsTable.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
