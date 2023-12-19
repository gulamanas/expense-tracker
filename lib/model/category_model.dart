import 'dart:convert';

class Category {
  static int _idCounter = 0;
  final int id;
  final String name;

  Category(this.id, this.name);

  factory Category.autoIncrement(String name) {
    final newId = _idCounter++;
    return Category(newId, name);
  }

  // Convert Category list to JSON string
  static String listToJson(List<Category> categories) {
    List<Map<String, dynamic>> jsonData =
        categories.map((e) => e.toJson()).toList();
    return jsonEncode(jsonData);
  }

  // Convert JSON string to Category list
  static List<Category> listFromJson(String jsonString) {
    List<Map<String, dynamic>> jsonData =
        jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return jsonData.map((e) => Category.fromJson(e)).toList();
  }

  // Convert Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Convert JSON to Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['id'] ?? 0,
      json['name'],
    );
  }
}
