import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../list_manager.dart'; // Ensure correct ListManager import
import 'listItemsPage.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  _MyListsPageState createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  late ListManager _listManager;

  List<int> selectedItems = []; // List to track selected item indices
  List<int> removedItems = []; // List to track long-pressed item indices
  List<int> notFoundItems = []; // List to track long-pressed item indices

  @override
  void initState() {
    super.initState();
    _listManager = ListManager();
    _loadShoppingLists(); // Load shopping lists without checking permissions
  }

  Future<void> _loadShoppingLists() async {
    await _listManager.loadActiveShoppingLists(); // Load lists from XML
    print("======================== Load Shopping Lists ========================");
    setState(() {}); // Rebuild the UI after loading
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myLists),
      ),
      body: ListView.builder(
        itemCount: _listManager.myLists.length,
        itemBuilder: (context, index) {
          // Extract ListID and ListName from myLists
          String listID = _listManager.myLists[index]['listID']!;
          String listName = _listManager.myLists[index]['listName']!;

          return Dismissible(
            key: Key(listID), // Use a unique key for each list item
            direction: DismissDirection.horizontal, // Allow swiping in both directions
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
                // Confirm archive action
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.confirmArchieve),
                      content: Text('${AppLocalizations.of(context)!.confirmArchieveInfo}$listName?'),
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
                                  _setAsArchieved(listID); // Archive logic
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$listName archived')),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.green,
                                ),
                                icon: Icon(Icons.archive),
                                label: Text(AppLocalizations.of(context)!.setAsArchieved),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else if (direction == DismissDirection.endToStart) {
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
            onDismissed: (direction) {
              // No additional logic needed here since actions are handled in confirmDismiss
            },
            child: ListTile(
              title: Text(listName), // Display the list name
              onTap: () {
                _showListItemsDialog(context, listID, listName, true); //Show Edit popup
              },
              onLongPress: (){
                _showListItemsDialog(context, listID, listName, false); //Show Archive popup
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Long Press')),
                // );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListItemsPage(
                onSave: (String listName) {
                  _onNewListSaved(context, listName);
                },
                itemsTable: [],
              ),
            ),
          ).then((_) async {
            _loadShoppingLists();
            //setState(() {}); // Trigger UI update
          });
        },
        tooltip: 'Add New List',
        heroTag: null,
        child: const Icon(Icons.add),
      ),

    );
  }


  void _onNewListSaved(BuildContext context, String listName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('New List "$listName" added!')),
    );
  }

  // Make this method async to await the setAsArchieved operation
  Future<void> _setAsArchieved(String listID) async {
    await _listManager.setArchieveStatus(listID,"0"); // Wait for the archiving to complete
    setState(() {
      // Optionally refresh the lists or any state you are using
    });
  }

  Future<void> _saveEditedList(String listID) async {
    print("Selected $selectedItems");
    print("Removed $removedItems");
    print("Not Found $notFoundItems");
    await _listManager.updateList(listID, selectedItems, removedItems, notFoundItems); // Wait for the archiving to complete
    setState(() {
      // Optionally refresh the lists or any state you are using
    });
  }

  // Update the _showListItemsDialog method
  void _showListItemsDialog(BuildContext context, String listID, String listName, bool type) {
    // Fetch the items for the selected list using ListID
    List<Map<String, String>> items = _listManager.getItemsForList(listID);

    /*
      Checked = -1 Not Found
      Checked = 0 Not Available / Forgotten
      Checked = 1 Purchased
    */

    selectedItems.clear();
    removedItems.clear();
    notFoundItems.clear();
    // Initialize selectedItems based on the initial checked status from the XML
    for (int i = 0; i < items.length; i++) {
      if (items[i]['checked'] == "1") {
        selectedItems.add(i); // Mark the item as selected if checked in XML
      }
      if (items[i]['checked'] == "0") {
        removedItems.add(i); // Mark the item as selected if checked in XML
      }
      if (items[i]['checked'] == "-1") {
        notFoundItems.add(i); // Mark the item as selected if checked in XML
      }
    }

    if (type == false) {
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
                        onTap: () {
                          setState(() {
                            // Toggle selection: add to list if not selected, remove if already selected
                            // Check if the item is marked with an "X"
                            if (removedItems.contains(index)) {
                              print("if");
                              // If it has an "X", toggle to checked
                              removedItems.remove(index); // Remove from long-pressed items
                              selectedItems.add(index); // Add to selected items
                            } else {
                              // Toggle selection for checkmark
                              if (selectedItems.contains(index)) {
                                print("else if");
                                selectedItems.remove(index); // Uncheck it
                                notFoundItems.add(index);
                              } else {
                                print("if else");
                                selectedItems.add(index); // Check it
                                notFoundItems.remove(index);
                              }
                            }
                          });
                          //print("onTap -- ${item['name']} - ${item['quantity']} ${item['unit']} == ${selectedItems[index]}");
                        },
                        onDoubleTap: () {
                          setState(() {
                            // Mark the item as long-pressed
                            if (removedItems.contains(index)) {
                              removedItems.remove(index); // Remove from long-pressed items
                              notFoundItems.add(index);
                            } else {
                              removedItems.add(index); // Add to long-pressed items
                              selectedItems.remove(index);
                              notFoundItems.remove(index);
                            }
                          });
                          //print("onLongPress -- ${item['name']} - ${item['quantity']} ${item['unit']} == ${longPressedItems[index]}");
                        },
                        child: SizedBox(
                          height: 28, // Adjusted height for better spacing
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24, // Fixed width for check icon
                                child: removedItems.contains(index)
                                    ? Icon(Icons.cancel, color: Colors
                                    .red) // Show X icon on long press
                                    : (selectedItems.contains(index)
                                    ? Icon(Icons.check, color: Colors
                                    .green) // Show check if selected
                                    : null),
                              ),
                              SizedBox(width: 8),
                              // Spacing between icon and text
                              Expanded(
                                child: Text(
                                    '${item['name']} - ${item['quantity']} ${item['unit']}'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          await _saveEditedList(listID);
                          await _setAsArchieved(listID); // Await the archiving operation
                          Navigator.of(context).pop(); // Close the dialog after archiving
                          await _loadShoppingLists(); // Reload the shopping lists after closing
                        },
                        icon: Icon(Icons.archive),
                        label: Text(AppLocalizations.of(context)!.setAsArchieved),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green, // Change this to any color you like
                        ),
                      ),
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      );
    }else{
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
                        onTap: () {
                          setState(() {
                            // Toggle selection: add to list if not selected, remove if already selected
                            // Check if the item is marked with an "X"
                            if (removedItems.contains(index)) {
                              print("if");
                              // If it has an "X", toggle to checked
                              removedItems.remove(index); // Remove from long-pressed items
                              selectedItems.add(index); // Add to selected items
                            } else {
                              // Toggle selection for checkmark
                              if (selectedItems.contains(index)) {
                                print("if if");
                                selectedItems.remove(index); // Uncheck it
                                notFoundItems.add(index);
                              } else {
                                print("else");
                                selectedItems.add(index); // Check it
                                notFoundItems.remove(index);
                              }
                            }
                          });
                          //print("onTap -- ${item['name']} - ${item['quantity']} ${item['unit']} == ${selectedItems[index]}");
                        },
                        onDoubleTap: () {
                          setState(() {
                            // Mark the item as long-pressed
                            if (removedItems.contains(index)) {
                              removedItems.remove(index); // Remove from long-pressed items
                              notFoundItems.add(index);
                            } else {
                              removedItems.add(index); // Add to long-pressed items
                              selectedItems.remove(index);
                              notFoundItems.remove(index);
                            }
                          });
                          //print("onLongPress -- ${item['name']} - ${item['quantity']} ${item['unit']} == ${longPressedItems[index]}");
                        },
                        child: SizedBox(
                          height: 28, // Adjusted height for better spacing
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24, // Fixed width for check icon
                                child: removedItems.contains(index)
                                    ? Icon(Icons.cancel, color: Colors
                                    .red) // Show X icon on long press
                                    : (selectedItems.contains(index)
                                    ? Icon(Icons.check, color: Colors
                                    .green) // Show check if selected
                                    : null),
                              ),
                              SizedBox(width: 8),
                              // Spacing between icon and text
                              Expanded(
                                child: Text(
                                    '${item['name']} - ${item['quantity']} ${item['unit']}'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          await _saveEditedList(listID); // Await the archiving operation
                          Navigator.of(context).pop(); // Close the dialog after archiving
                          await _loadShoppingLists(); // Reload the shopping lists after closing
                        },
                        icon: Icon(Icons.save),
                        label: Text(AppLocalizations.of(context)!.save),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green, // Change this to any color you like
                        ),
                      ),
                      TextButton(
                        child: Text(AppLocalizations.of(context)!.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
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
}