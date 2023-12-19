// category_provider.dart
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  CategoryProvider() {
    _loadCategories();
  }

  List<Category> _categories = [];

  List<Category> get categories => _categories;

  void _loadCategories() async {
    _prefs = await SharedPreferences.getInstance();
    String categoriesJson = _prefs.getString('categories') ?? '[]';
    _categories = Category.listFromJson(categoriesJson);
    notifyListeners();
  }

  void _saveCategories() {
    String categoriesJson = Category.listToJson(_categories);
    _prefs.setString('categories', categoriesJson);
  }

  void addCategory(String name) {
    int newId = _categories.isEmpty ? 1 : _categories.last.id + 1;
    _categories.add(Category(newId, name));
    _saveCategories();
    notifyListeners();
  }

  void updateCategory(int id, String name) {
    int index = _categories.indexWhere((category) => category.id == id);
    if (index != -1) {
      _categories[index] = Category(id, name);
      _saveCategories();
      notifyListeners();
    }
  }

  // Other methods for category management as needed
}
