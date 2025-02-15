import 'package:flutter/material.dart';
import 'package:super_market_list/data/chicken_data.dart';
import 'package:super_market_list/data/hygiene_data.dart';
import 'package:super_market_list/data/vegetables_data.dart';
import 'package:super_market_list/data/milkproducts_data.dart';
import '../data/cow_data.dart';
import '../data/pork_data.dart';
import '../l10n/app_localizations.dart';

enum Category { Vegetables, Hygiene, MilkProduct, Chicken, Cow, Pork }

class CategoryPage extends StatefulWidget {
  final Category category;
  final List<Map<String, dynamic>> itemsTable;

  const CategoryPage({
    super.key,
    required this.category,
    required this.itemsTable,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<dynamic> _allItems;
  List<dynamic> _filteredItems = [];
  bool _initialized = false;  // To ensure initialization only happens once

  @override
  void initState() {
    super.initState();

    // Add a listener to filter items as the user types in the search field
    _searchController.addListener(() {
      search(_searchController.text);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ensure this is only done once by checking the _initialized flag
    if (!_initialized) {
      // Load items based on category
      _allItems = widget.category == Category.Vegetables
          ? getVegetables(context)
          : widget.category == Category.Hygiene
          ? getHygieneProducts(context)
          : widget.category == Category.Chicken
          ? getChickenProducts(context)
          : widget.category == Category.Cow
          ? getCowProducts(context)
          : widget.category == Category.Pork
          ? getPorkProducts(context)
          : getMilkProducts(context);

      // Initially, show all items
      _filteredItems = List.from(_allItems);
      _initialized = true; // Set flag to true so this only runs once
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String normalizeText(String text) {
    return text
        .toLowerCase()
        .characters
        .map((char) {
      switch (char) {
        case 'ά': return 'α';
        case 'έ': return 'ε';
        case 'ή': return 'η';
        case 'ί': return 'ι';
        case 'ό': return 'ο';
        case 'ύ': return 'υ';
        case 'ώ': return 'ω';
        case 'ϊ': return 'ι';
        case 'ϋ': return 'υ';
        case 'ΰ': return 'υ';
        default: return char;
      }
    })
        .join();
  }

  void search(String text) {
    setState(() {
      if (text.isEmpty) {
        // If the search field is empty, show all items
        _filteredItems = List.from(_allItems);
      } else {
          final normalizedText = normalizeText(text);
          _filteredItems = _allItems.where((item) {
            final itemNameNormalized = normalizeText(item.name);
            return itemNameNormalized.contains(normalizedText);
          }).toList();
      }
    });
  }

  void storeQuantity(BuildContext context, String itemName, String unit, num quantity, AssetImage? image, IconData? icon) {
    Map<String, dynamic> itemEntry = {
      'name': itemName,
      'unit': unit,
      'quantity': quantity,
      'image': image,
      'icon': icon
    };

    widget.itemsTable.add(itemEntry);
    print("--------------------------------------------------------------\n");
    for (var item in widget.itemsTable) {
      print('Item: ${item['name']}, Quantity: ${item['quantity']} ${item['unit']} ${item['image']} ${item['icon']}');
    }
    print("--------------------------------------------------------------\n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                widget.category == Category.Vegetables
                    ? AppLocalizations.of(context)!.vegetables
                    : widget.category == Category.Hygiene
                    ? AppLocalizations.of(context)!.hygieneProducts
                    : widget.category == Category.Chicken
                    ? AppLocalizations.of(context)!.chickenProducts
                    : widget.category == Category.MilkProduct
                    ? AppLocalizations.of(context)!.milkProducts
                    : widget.category == Category.Cow
                    ? AppLocalizations.of(context)!.cowProducts
                    : widget.category == Category.Pork
                    ? AppLocalizations.of(context)!.porkProducts
                    : '' // Add a fallback if none of the categories match
            ),
            SizedBox(
              width: 150, // Adjust width as needed
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController controller = TextEditingController();
                  return AlertDialog(
                    title: Text('Select Quantity for ${item.name}'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${AppLocalizations.of(context)!.enterQuantityIn} ${item.unit}'),
                        TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.add),
                        onPressed: () {
                          final input = controller.text;
                          if (input.isNotEmpty) {
                            if (item.unit == 'bottles' || item.unit == 'pieces' || item.unit == 'packs' || item.unit == 'tubes') {
                              if (int.tryParse(input) != null) {
                                int quantity = int.parse(input);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected quantity: $quantity ${item.unit}')),
                                );
                                storeQuantity(context, item.name, item.unit, quantity, item.image, item.icon);
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid integer for ${item.unit}')),
                                );
                              }
                            } else if (item.unit == 'kg') {
                              if (double.tryParse(input) != null) {
                                double quantity = double.parse(input);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected quantity: $quantity ${item.unit}')),
                                );
                                storeQuantity(context, item.name, item.unit, quantity, item.image, item.icon);
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid double number for ${item.unit}')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid unit')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a value')),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (item.icon != null)
                    Icon(item.icon, size: 30.0, color: Colors.blue,)
                  else if (item.image != null)
                    Image(image: item.image, width: 30.0, height: 30.0, fit: BoxFit.contain),
                  const SizedBox(height: 8.0),
                  Text(item.name),
                  const SizedBox(height: 8.0),
                  Text('Unit: ${item.unit}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
