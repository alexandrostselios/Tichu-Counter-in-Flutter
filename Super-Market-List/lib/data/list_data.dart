// lib/data/list_data.dart
class ListData {
  // Singleton instance
  static final ListData _instance = ListData._internal();

  // Private constructor
  ListData._internal();

  // Factory constructor to return the same instance
  factory ListData() {
    return _instance;
  }

  // List to hold the names of the lists
  final List<String> myLists = [];

  void addList(String listName) {
    myLists.add(listName);
  }
}
