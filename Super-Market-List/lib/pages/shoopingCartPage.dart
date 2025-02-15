import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../list_manager.dart';

class ShoppingCartPage extends StatefulWidget {
  final Function(String) onSave;
  final List<Map<String, dynamic>> itemsTable;

  const ShoppingCartPage({super.key, required this.onSave, required this.itemsTable});

  @override
  _ShoppingCartPage createState() => _ShoppingCartPage();
}

class _ShoppingCartPage extends State<ShoppingCartPage> {
  late final List<Map<String, dynamic>> itemsTable;
  final ListManager _listManager = ListManager();

  // Consolidated items list
  List<Map<String, dynamic>> consolidatedItems = [];

  @override
  void initState() {
    super.initState();
    itemsTable = widget.itemsTable;
    _consolidateItems(); // Initialize the consolidated list
  }

  // Function to consolidate items initially
  Future<void> _consolidateItems() async {
    consolidatedItems = await _checkForMoreEntries(itemsTable);
    setState(() {}); // Rebuilds the widget to show the updated consolidated list
  }

  Future<void> _generateAndSaveXML(BuildContext context) async {
    if (consolidatedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No items selected')),
      );
      return;
    }

    String? listName = await _showListNameDialog(context);
    if (listName == null || listName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('List name cannot be empty')),
      );
      return;
    }

    // Save the XML file using consolidated items
    await _listManager.saveXML(context, listName, consolidatedItems);
    widget.onSave(listName);
    itemsTable.clear(); // Clear the items after saving

    Navigator.of(context).popUntil((route) => route.isFirst); // Navigate back to the main page
  }

  // Dialog to enter a list name
  Future<String?> _showListNameDialog(BuildContext context) async {
    String listName = '';
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.setListName),
          content: TextField(
            onChanged: (value) {
              listName = value;
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.listNameExample,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.save),
              onPressed: () {
                Navigator.of(context).pop(listName);
              },
            ),
          ],
        );
      },
    );
  }

  void updateQuantity(BuildContext context, String itemName, String unit, num quantity) {
    bool itemUpdated = false;

    // Update specified entry in consolidatedItems
    for (var item in consolidatedItems) {
      if (item['name'] == itemName && item['unit'] == unit) {
        item['quantity'] = quantity; // Update quantity
        itemUpdated = true;
        break;
      }
    }

    // If no match, add it
    if (!itemUpdated) {
      consolidatedItems.add({
        'name': itemName,
        'unit': unit,
        'quantity': quantity,
      });
    }

    setState(() {}); // Refresh UI to show updated quantity
  }

  Future<List<Map<String, dynamic>>> _checkForMoreEntries(List<Map<String, dynamic>> items) async {
    Map<String, Map<String, dynamic>> itemMap = {};

    for (var item in items) {
      String key = '${item['name']}_${item['unit']}';
      if (itemMap.containsKey(key)) {
        itemMap[key]!['quantity'] += item['quantity'];
      } else {
        itemMap[key] = {
          'name': item['name'],
          'quantity': item['quantity'],
          'unit': item['unit'],
          'image': item['image'],
          'icon': item['icon']
        };
      }
    }
    return itemMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.shoppingCart),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _generateAndSaveXML(context);
            },
          ),
        ],
      ),
      body: consolidatedItems.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.emptyShoppingCartInfo))
          : ListView.builder(
        itemCount: consolidatedItems.length,
        itemBuilder: (context, index) {
          final item = consolidatedItems[index];
          print("Image path: ${item['image']}");
          print("Image path: ${item['icon']}");
          return ListTile(
            leading: item['image'] != null
                ? (item['image'] is AssetImage
                ? Image(image: item['image'], width: 50, height: 50, fit: BoxFit.cover)
                : item['image'] is String
                ? Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover)
                : Icon(Icons.image_not_supported, size: 50))
                : item['icon'] != null
                ? Icon(item['icon'], size: 50, color: Colors.blue) // Use IconData if available
                : Icon(Icons.image_not_supported, size: 50), // Fallback if both are null
            title: Text(item['name']),
            subtitle: Text(
              '${AppLocalizations.of(context)!.quantity} ${item['quantity']} ${item['unit']}',
            ),
            onTap: () {
              // Show dialog to edit quantity
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController controller = TextEditingController();
                  return AlertDialog(
                    //title: Text(item['name']),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Use a Row to place the image/icon and title in the same row
                        Row(
                          children: [
                            // Image or Icon with a width and height of 20
                            item['image'] != null
                                ? (item['image'] is AssetImage
                                ? Image(image: item['image'], width: 20, height: 20, fit: BoxFit.cover)
                                : item['image'] is String
                                ? Image.asset(item['image'], width: 20, height: 20, fit: BoxFit.cover)
                                : Icon(Icons.image_not_supported, size: 20))
                                : item['icon'] != null
                                ? Icon(item['icon'], size: 20, color: Colors.blue)
                                : Icon(Icons.image_not_supported, size: 20),
                            SizedBox(width: 8), // Add some space between image/icon and title
                            // Title comes next to the image/icon in the same row
                            Expanded(
                              child: Text(item['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(height: 16), // Space between the row and input field
                        // Now display the quantity input
                        Text('Enter quantity in ${item['unit']}'),
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
                            if (item['unit'] == 'bottles' || item['unit'] == 'pieces' || item['unit'] == 'packs' || item['unit'] == 'tubes') {
                              if (int.tryParse(input) != null) {
                                int quantity = int.parse(input);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected quantity: $quantity ${item['unit']}')),
                                );
                                updateQuantity(context, item['name'], item['unit'], quantity);
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid integer for ${item['unit']}')),
                                );
                              }
                            } else if (item['unit'] == 'kg') {
                              if (double.tryParse(input) != null) {
                                double quantity = double.parse(input);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected quantity: $quantity ${item['unit']}')),
                                );
                                updateQuantity(context, item['name'], item['unit'], quantity);
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please enter a valid double number for ${item['unit']}')),
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
          );
        },
      ),
    );
  }
}
