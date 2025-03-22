import 'package:bloc_example/item_model.dart';

class ItemRepository {
  
  final List<Item> _items= [];

  Future<List<Item>> fetchItems() async {
   await Future.delayed(Duration(seconds: 2));
   return _items;
  }

  Future<void> addItem(Item item) async {
   await Future.delayed(Duration(seconds: 2));
   _items.add(item);  
  }

   Future<void> updateItem(Item updatedItem) async {
   await Future.delayed(Duration(seconds: 2));
   final index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _items[index] = updatedItem;
    } 
  }

  Future<void> deleteItem(String id) async {
    await Future.delayed(Duration(seconds: 2));
    _items.removeWhere((item) => item.id == id);
  }
}