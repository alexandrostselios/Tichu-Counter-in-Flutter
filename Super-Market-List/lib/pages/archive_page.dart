import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../list_manager.dart';

class ArchivedPage extends StatefulWidget {
  const ArchivedPage({super.key});

  @override
  ArchivedPageState createState() => ArchivedPageState();
}

class ArchivedPageState extends State<ArchivedPage> {
  late ListManager _listManager;

  @override
  void initState() {
    super.initState();
    _listManager = ListManager();
    _loadShoppingLists(); // Load shopping lists without checking permissions
  }

  Future<void> _loadShoppingLists() async {
    await _listManager.loadArchievedShoppingLists(); // Load lists from XML
    setState(() {}); // Rebuild the UI after loading
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.archieved),
      ),
      body: ListView.builder(
        itemCount: _listManager.myLists.length,
        itemBuilder: (context, index) {
          // Extract ListID and ListName from myLists
          String listID = _listManager.myLists[index]['listID']!;
          String listName = _listManager.myLists[index]['listName']!;
          return Dismissible(
            key: Key(listID), // Use a unique key for each list item
            direction: DismissDirection.horizontal, // Allow swiping to the right
            background: Container(
              color: Colors.green, // Background color when swiped to archive
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16.0),
              child: const Icon(
                Icons.archive,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red, // Background color when swiped to delete
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
              // Optional: Show a confirmation dialog before deletion
              return await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.confirmActive),
                    content: Text('${AppLocalizations.of(context)!.confirmActiveInfo}$listName?'),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Aligns everything to the left initially
                        mainAxisSize: MainAxisSize.max,  // Allows the row to take up the available space
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false), // Cancel
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              _setAsNotArchieved(listID); // Archive logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$listName archived')),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 2), // Reduce horizontal padding
                            ),
                            icon: Icon(Icons.archive),
                            label: Text(AppLocalizations.of(context)!.setAsNotArchieved),
                          ),
                        ],
                      ),
                    ],
                  );

                },
              );
            }else if (direction == DismissDirection.endToStart) {
                // Confirm delete action
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.confirmDelete),
                      content: Text('${AppLocalizations.of(context)!.confirmDeleteInfo}$listName?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false), // Cancel
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            // Handle deletion of the list
                            _listManager.deleteList(listID); // Replace with your actual delete logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$listName deleted')),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          icon: Icon(Icons.delete),
                          label: Text(AppLocalizations.of(context)!.delete),
                        ),
                      ],
                    );
                  },
                );
            }
              return false; // In case of no action
            },
            child: ListTile(
              title: Text(listName), // Display the list name
              onTap: () {
                _showListItemsDialog(context, listID, listName);
              },
            ),
          );
          // return ListTile(
          //   title: Text(listName), // Display the list name
          //   onTap: () {
          //     _showListItemsDialog(context, listID, listName);
          //   },
          // );
        },
      ),
    );
  }

  // Make this method async to await the setAsArchieved operation
  Future<void> _setAsNotArchieved(String listID) async {
    await _listManager.setArchieveStatus(listID,"1"); // Wait for the archiving to complete
    setState(() {
      // Optionally refresh the lists or any state you are using
    });
  }

  // New method to show the items dialog
  void _showListItemsDialog(BuildContext context, String listID, String listName) {
    // Fetch the items for the selected list using ListID
    List<Map<String, String>> items = _listManager.getItemsForList(listID);
    List<int> selectedItems = []; // List to track selected item indices
    List<int> longPressedItems = []; // List to track long-pressed item indices

    /*
      Checked = -1 No Information Available
      Checked = 0 Not Found
      Checked = 1 Purchased
    */
    // Initialize selectedItems based on the initial checked status from the XML
    for (int i = 0; i < items.length; i++) {
      if (items[i]['checked'] == "1") {
        selectedItems.add(i); // Mark the item as selected if checked in XML
      }
      if (items[i]['checked'] == "0") {
        longPressedItems.add(i); // Mark the item as selected if checked in XML
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(listName), // Show the ListName in the title
              content: SingleChildScrollView(
                child: ListBody(
                  children: items
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    var item = entry.value;

                    return GestureDetector(
                      // onTap: () {
                      //   setState(() {
                      //     // Toggle selection: add to list if not selected, remove if already selected
                      //     if (selectedItems.contains(index)) {
                      //       selectedItems.remove(index);
                      //     } else {
                      //       selectedItems.add(index);
                      //     }
                      //   });
                      // },
                      child: SizedBox(
                        height: 26, // Adjusted height for better spacing
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24, // Fixed width for check icon
                              child: longPressedItems.contains(index)
                                  ? Icon(Icons.cancel, color: Colors.red) // Show X icon on long press
                                  : (selectedItems.contains(index)
                                  ? Icon(Icons.check, color: Colors.green) // Show check if selected
                                  : null),
                            ),
                            SizedBox(width: 8), // Spacing between icon and text
                            Expanded(
                              child: Text('${item['name']} - ${item['quantity']} ${item['unit']}'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min, // Use min size to fit buttons without overflowing
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between buttons evenly
                  children: [
                    // TextButton.icon(
                    //   onPressed: () {
                    //     Navigator.of(context).pop(); // Close the dialog
                    //   },
                    //   icon: Icon(Icons.delete), // Icon to be displayed
                    //   label: Text(AppLocalizations.of(context)!.delete), // Text to be displayed
                    //   style: TextButton.styleFrom(
                    //     foregroundColor: Colors.red, // Change this to any color you like
                    //   ),
                    // ),
                    // Archive button
                    SizedBox(
                      width: 181, // Set a fixed width for the archive button
                      child: TextButton.icon(
                        onPressed: () async {
                          await _setAsNotArchieved(listID);
                          Navigator.of(context).pop();
                          await _loadShoppingLists();
                        },
                        icon: Icon(Icons.archive),
                        label: Text(
                          AppLocalizations.of(context)!.setAsNotArchieved,
                          style: TextStyle(fontSize: 14), // Adjust font size if needed
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    //SizedBox(width: 8), // Space between buttons
                    // Close button
                    SizedBox(
                      width: 75, // Set a fixed width for the close button
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: TextStyle(
                            fontSize: 14, // Adjust font size if needed
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}