import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

class ListManager {
  List<Map<String, String>> myLists = []; // Store your list names and IDs here
  final Map<String, List<Map<String, String>>> _listItems = {}; // Map to store list items by ListID

  static const String dummyXmlData = '''<?xml version="1.0" encoding="UTF-8"?>
<ShoppingList>
  <List>
    <ListID>1</ListID>
    <ListName>List 1</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Apple</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Banana</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Watermelon</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>3</ItemID>
      <ItemName>Potatos</ItemName>
      <Quantity>3.5</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>4</ItemID>
      <ItemName>Carrot</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>2</ListID>
    <ListName>List 2</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Apple</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Banana</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Watermelon</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>3</ItemID>
      <ItemName>Potatos</ItemName>
      <Quantity>3.5</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>4</ItemID>
      <ItemName>Carrot</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>3</ListID>
    <ListName>List 3</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Apple</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Banana</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Watermelon</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>3</ItemID>
      <ItemName>Potatos</ItemName>
      <Quantity>3.5</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>4</ItemID>
      <ItemName>Carrot</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>4</ListID>
    <ListName>List 4</ListName>
    <ListActive>1</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Apple</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Banana</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Watermelon</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>3</ItemID>
      <ItemName>Potatos</ItemName>
      <Quantity>3.5</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>4</ItemID>
      <ItemName>Carrot</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>5</ListID>
    <ListName>Groceries 5</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Apple</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Banana</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Watermelon</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Potato</ItemName>
      <Quantity>3.5</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>3</ItemID>
      <ItemName>Carrot</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>6</ListID>
    <ListName>Groceries 6</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Orange</ItemName>
      <Quantity>4</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Strawberry</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Pineapple</ItemName>
      <Quantity>2</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
  </List>
  <List>
    <ListID>7</ListID>
    <ListName>Groceries 7</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Grapes</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Pear</ItemName>
      <Quantity>6</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Onion</ItemName>
      <Quantity>4</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>8</ListID>
    <ListName>Groceries 8</ListName>
    <ListActive>1</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Mango</ItemName>
      <Quantity>3</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Tomato</ItemName>
      <Quantity>2.5</Quantity>
      <Unit>kg</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Cucumber</ItemName>
      <Quantity>6</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>3</ItemID>
      <ItemName>Apple</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>4</ItemID>
      <ItemName>Banana</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>5</ItemID>
      <ItemName>Watermelon</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>6</ItemID>
      <ItemName>Potatos</ItemName>
      <Quantity>3.5</Quantity>
      <Unit>kg</Unit>
      <Checked>-1</Checked>
    </Item>
    <Item>
      <ItemID>7</ItemID>
      <ItemName>Carrot</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>8</ItemID>
      <ItemName>Blueberries</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>9</ItemID>
      <ItemName>Cabbage</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>9</ItemID>
      <ItemName>Bell Pepper</ItemName>
      <Quantity>3</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>11</ItemID>
      <ItemName>Olive Oil</ItemName>
      <Quantity>1</Quantity>
      <Unit>liter</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>12</ItemID>
      <ItemName>Vinegar</ItemName>
      <Quantity>500</Quantity>
      <Unit>ml</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>13</ItemID>
      <ItemName>Honey</ItemName>
      <Quantity>250</Quantity>
      <Unit>g</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>14</ItemID>
      <ItemName>Kiwi</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>15</ItemID>
      <ItemName>Peach</ItemName>
      <Quantity>2</Quantity>
      <Unit>pcs</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>16</ItemID>
      <ItemName>Cherries</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>17</ItemID>
      <ItemName>Papaya</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>18</ItemID>
      <ItemName>Raspberry</ItemName>
      <Quantity>250</Quantity>
      <Unit>g</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>19</ItemID>
      <ItemName>Celery</ItemName>
      <Quantity>1</Quantity>
      <Unit>bunch</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>20</ItemID>
      <ItemName>Radish</ItemName>
      <Quantity>500</Quantity>
      <Unit>g</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>21</ItemID>
      <ItemName>Garlic</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>22</ItemID>
      <ItemName>Asparagus</ItemName>
      <Quantity>1</Quantity>
      <Unit>bunch</Unit>
      <Checked>0</Checked>
    </Item>
  </List>
  <List>
    <ListID>10</ListID>
    <ListName>Groceries 10</ListName>
    <ListActive>1</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Blueberries</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Cabbage</ItemName>
      <Quantity>2</Quantity>
      <Unit>kg</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Bell Pepper</ItemName>
      <Quantity>3</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>11</ListID>
    <ListName>Groceries 11</ListName>
    <ListActive>1</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Kiwi</ItemName>
      <Quantity>5</Quantity>
      <Unit>pcs</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Peach</ItemName>
      <Quantity>2</Quantity>
      <Unit>pcs</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Cherries</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>12</ListID>
    <ListName>Groceries 12</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Papaya</ItemName>
      <Quantity>1</Quantity>
      <Unit>pcs</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Raspberry</ItemName>
      <Quantity>250</Quantity>
      <Unit>g</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Celery</ItemName>
      <Quantity>1</Quantity>
      <Unit>bunch</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>13</ListID>
    <ListName>Groceries 13</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Radish</ItemName>
      <Quantity>500</Quantity>
      <Unit>g</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Garlic</ItemName>
      <Quantity>1</Quantity>
      <Unit>kg</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Asparagus</ItemName>
      <Quantity>1</Quantity>
      <Unit>bunch</Unit>
      <Checked>0</Checked>
    </Item>
  </List>
  <List>
    <ListID>14</ListID>
    <ListName>Groceries 14</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Olive Oil</ItemName>
      <Quantity>1</Quantity>
      <Unit>liter</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Vinegar</ItemName>
      <Quantity>500</Quantity>
      <Unit>ml</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Honey</ItemName>
      <Quantity>250</Quantity>
      <Unit>g</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
  <List>
    <ListID>15</ListID>
    <ListName>Groceries 15</ListName>
    <ListActive>0</ListActive>
    <Item>
      <ItemID>0</ItemID>
      <ItemName>Coconut Water</ItemName>
      <Quantity>1</Quantity>
      <Unit>liter</Unit>
      <Checked>1</Checked>
    </Item>
    <Item>
      <ItemID>1</ItemID>
      <ItemName>Almond Milk</ItemName>
      <Quantity>1</Quantity>
      <Unit>liter</Unit>
      <Checked>0</Checked>
    </Item>
    <Item>
      <ItemID>2</ItemID>
      <ItemName>Oatmeal</ItemName>
      <Quantity>500</Quantity>
      <Unit>g</Unit>
      <Checked>1</Checked>
    </Item>
  </List>
</ShoppingList>
''';
  String fileName = 'ShoppingList.xml';

  Future<void> loadActiveShoppingLists() async {
    try {
      // Get the documents directory for the app
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/ShoppingList.xml';

      File file = File(filePath);

      if (await file.exists()) {
        String xmlString = await file.readAsString();
        final xmlDocument = XmlDocument.parse(xmlString); // Use the class from xml package
        final lists = xmlDocument.findAllElements('List');

        myLists = lists
        // First filter out lists where ListActive is '1'
            .where((list) {
          final listActive = list.findElements('ListActive').single.text;
          return listActive.trim() != '0'; // Keep lists where ListActive is not '0'
        })
            .map((list) {
          final listID = list.findElements('ListID').single.text; // Fetch ListID
          final listName = list.findElements('ListName').single.text; // Fetch ListName

          // Store the ListID and items for this list in the map
          _listItems[listID] = list.findAllElements('Item').map((item) {
            return {
              'itemID': item.findElements('ItemID').single.text,
              'name': item.findElements('ItemName').single.text,
              'quantity': item.findElements('Quantity').single.text,
              'unit': item.findElements('Unit').single.text,
              'checked': item.findElements('Checked').single.text,
            };
          }).toList();

          return {
            'listID': listID, // Add ListID
            'listName': listName // Add ListName
          }; // Store both ListName and ListID in myLists
        }).toList();
      } else {
        print("--------------------- NO XML ENTRY ---------------------");
        myLists = []; // If the file doesn't exist, initialize with an empty list
      }
    } catch (e) {
      // Handle any exceptions that may occur
      print('Error loading shopping lists: $e');
      myLists = []; // Reset to empty list on error
    }
  }

  Future<void> loadArchievedShoppingLists() async {
    try {
      // Get the documents directory for the app
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/ShoppingList.xml';

      File file = File(filePath);

      if (await file.exists()) {
        String xmlString = await file.readAsString();
        final xmlDocument = XmlDocument.parse(xmlString); // Use the class from xml package
        final lists = xmlDocument.findAllElements('List');

        myLists = lists
        // First filter out lists where ListActive is '0'
            .where((list) {
          final listActive = list.findElements('ListActive').single.text;
          return listActive.trim() != '1'; // Keep lists where ListActive is not '1'
        })
            .map((list) {
          final listID = list.findElements('ListID').single.text; // Fetch ListID
          final listName = list.findElements('ListName').single.text; // Fetch ListName

          // Store the ListID and items for this list in the map
          _listItems[listID] = list.findAllElements('Item').map((item) {
            return {
              'itemID': item.findElements('ItemID').single.text,
              'name': item.findElements('ItemName').single.text,
              'quantity': item.findElements('Quantity').single.text,
              'unit': item.findElements('Unit').single.text,
              'checked': item.findElements('Checked').single.text,
            };
          }).toList();

          return {
            'listID': listID, // Add ListID
            'listName': listName // Add ListName
          }; // Store both ListName and ListID in myLists
        }).toList();
      } else {
        myLists = []; // If the file doesn't exist, initialize with an empty list
      }
    } catch (e) {
      // Handle any exceptions that may occur
      print('Error loading shopping lists: $e');
      myLists = []; // Reset to empty list on error
    }
  }

  // New method to get items for a specific ListID
  List<Map<String, String>> getItemsForList(String listID) {
    return _listItems[listID] ?? []; // Return the items or an empty list if not found
  }

  // New method to set ListActive to 1 (archive) and return the list's items
  Future<List<Map<String, String>>?> setArchieveStatus(String listID, String isArcieved) async {
    print("ListID $listID ==== Archieve $isArcieved");
    try {
      // Get the documents directory for the app
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/ShoppingList.xml';

      File file = File(filePath);

      if (await file.exists()) {
        // Read the file and parse the XML
        String xmlString = await file.readAsString();
        final xmlDocument = XmlDocument.parse(xmlString);
        final lists = xmlDocument.findAllElements('List');

        // Find the list with the matching ListID
        final listElement = lists.firstWhere(
              (list) => list.findElements('ListID').single.text == listID,
          orElse: () => throw Exception("List with ListID $listID not found"),
        );

        // Set ListActive to '1'
        listElement.findElements('ListActive').single.innerText = isArcieved;

        // Save the updated XML back to the file
        await file.writeAsString(xmlDocument.toXmlString(pretty: true));

        // Return the items for the updated list
        return _listItems[listID];
      } else {
        print("File does not exist");
        return null;
      }
    } catch (e) {
      // Handle exceptions and return null on error
      print("Error archiving list: $e");
      return null;
    }
  }

  Future<List<Map<String, String>>?> deleteList(String listID) async {
    print("List ID to delete: $listID");

    try {
      // Get the documents directory for the app
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/ShoppingList.xml';

      File file = File(filePath);

      if (await file.exists()) {
        // Read the file and parse the XML
        String xmlString = await file.readAsString();
        final xmlDocument = XmlDocument.parse(xmlString);
        final lists = xmlDocument.findAllElements('List');

        // Find the list with the matching ListID
        lists.firstWhere(
              (list) => list.findElements('ListID').single.text == listID,
          orElse: () => throw Exception("List with ListID $listID not found"),
        );

        bool found = false;

        for (var list in lists) {
          var idElement = list.findElements('ListID').first;
          if (idElement.text == listID) {
            // Remove the <List> element that has a matching ListID
            list.parent?.children.remove(list);
            found = true;
          }
        }

        // If ListID is found and deleted, write the updated XML back to the file
        if (found) {
          print("List Found");
          final updatedXmlString = xmlDocument.toXmlString(pretty: true);
          await file.writeAsString(updatedXmlString);
        }


        // Return the items for the updated list
        return _listItems[listID];
      } else {
        print("File does not exist");
        return null;
      }
    } catch (e) {
      // Handle exceptions and return null on error
      print("Error deleting list: $e");
      return null;
    }
  }

  Future<List<Map<String, String>>?> updateList(String listID,List<int> selectedItems, List<int> removedItems, List<int> notFoundItems) async {
    try {
      // Get the documents directory for the app
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/ShoppingList.xml';

      File file = File(filePath);

      if (await file.exists()) {
        // Read the file and parse the XML
        String xmlString = await file.readAsString();
        final xmlDocument = XmlDocument.parse(xmlString);
        final lists = xmlDocument.findAllElements('List');

        // Find the list with the matching ListID
        final listElement = lists.firstWhere(
              (list) => list.findElements('ListID').single.text == listID,
          orElse: () => throw Exception("List with ListID $listID not found"),
        );

        // Find all items in the list and update the Checked value for matches
        final items = listElement.findElements('Item');
        for (var item in items) {
          // Assuming 'ItemID' is the child element containing the item's ID
          int itemID = int.parse(item.findElements('ItemID').single.text);

          // Check if the current ItemID matches any in doubleTapItems
          if (removedItems.contains(itemID)) {
            // Modify the Checked value
            item.findElements('Checked').single.innerText = '0';
          }

          if (selectedItems.contains(itemID)) {
            // Modify the Checked value
            item.findElements('Checked').single.innerText = '1';
          }

          if (notFoundItems.contains(itemID)) {
            // Modify the Checked value
            item.findElements('Checked').single.innerText = '-1';
          }
        }

        // Save the updated XML back to the file
        await file.writeAsString(xmlDocument.toXmlString(pretty: true));

        // Return the items for the updated list, adjust this if your _listItems structure is different
        print(_listItems[listID]);
        return _listItems[listID];
      } else {
        print("File does not exist");
        return null;
      }
    } catch (e) {
      // Handle exceptions and return null on error
      print("Error saving list: $e");
      return null;
    }
  }

  Future<void> saveXML(BuildContext context, String listName, List<Map<String, dynamic>> items) async {
    // Create a variable to determine whether to add the new list
    bool shouldAddList = listName != "MAIN DART";
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
    print("Total Items");
    for (var item in items) {
      print('Item: ${item['name']}, Quantity: ${item['quantity']} ${item['unit']}');
    }
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");

    try {
      // Use path_provider to get the correct directory
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/$fileName';

      File file = File(filePath);
      xml.XmlDocument xmlDocument;

      // Check if the file exists
      if (await file.exists()) {
        print("--------------------- FILE EXIST ---------------------");
        String xmlString = await file.readAsString();
        xmlDocument = xml.XmlDocument.parse(xmlString);
      } else {
        print("--------------------- CREATE LIST ---------------------");
        // Create a new XML document if it doesn't exist
        xmlDocument = xml.XmlDocument([xml.XmlElement(xml.XmlName('ShoppingList'))]);
        xmlDocument = xml.XmlDocument.parse(dummyXmlData);
      }

      final root = xmlDocument.rootElement;
      // int nextListId = root.findElements('List').length + 1;

      // Get the highest ListID by scanning the existing List elements
      int highestListId = root.findElements('List')
          .map((listElement) => int.parse(listElement.findElements('ListID').first.text))
          .fold(0, (prev, current) => current > prev ? current : prev);

      // Set the nextListId as the highestListId plus one
      int nextListId = highestListId + 1;

      int isActive = 1;
      if (shouldAddList) {
        final newList = xml.XmlElement(
          xml.XmlName('List'),
          [],
          [
            xml.XmlElement(xml.XmlName('ListID'), [], [xml.XmlText(nextListId.toString())]),
            xml.XmlElement(xml.XmlName('ListName'), [], [xml.XmlText(listName)]),
            xml.XmlElement(xml.XmlName('ListActive'), [], [xml.XmlText(isActive.toString())]),
            ...items.asMap().entries.map((entry) {
              int itemIndex = entry.key; // Get the index of the item in the list
              var item = entry.value; // Get the actual item

              // Create a unique ItemID using the list ID and item index
              String itemId = '$itemIndex';

              return xml.XmlElement(
                xml.XmlName('Item'),
                [],
                [
                  xml.XmlElement(xml.XmlName('ItemID'), [], [xml.XmlText(itemId)]), // Set the unique ItemID
                  xml.XmlElement(xml.XmlName('ItemName'), [], [xml.XmlText(item['name'] ?? 'Unknown Item')]),
                  xml.XmlElement(xml.XmlName('Quantity'), [], [xml.XmlText(item['quantity']?.toString() ?? '0')]),
                  xml.XmlElement(xml.XmlName('Unit'), [], [xml.XmlText(item['unit'] ?? 'Unknown Unit')]),
                  xml.XmlElement(xml.XmlName('Checked'), [], [xml.XmlText(item['checked'] ?? '-1')]),
                ],
              );
            }),
          ],
        );
        print("New List: $newList");
        root.children.add(newList); // Add new list to the XML root
      }

      print("BEFORE");
      await file.writeAsString(xmlDocument.toXmlString(pretty: true)); // Write back to the file
      print("AFTER");

      // Show success message
      print('List saved successfully');

      // Go back to the previous page after saving
      //Navigator.pop(context);
    } catch (e) {
      print('Error saving list: $e');
    }
  }
}