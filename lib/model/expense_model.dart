import 'dart:convert';

class Expense {
  late String title;
  late double price;
  final DateTime createdBy;

  Expense(this.title, this.price, this.createdBy);

  // Convert Expense list to JSON string
  static String listToJson(List<Expense> expenses) {
    List<Map<String, dynamic>> jsonData =
        expenses.map((e) => e.toJson()).toList();
    return jsonEncode(jsonData);
  }

  // Convert JSON string to Expense list
  static List<Expense> listFromJson(String jsonString) {
    List<Map<String, dynamic>> jsonData =
        jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return jsonData.map((e) => Expense.fromJson(e)).toList();
  }

  // Convert Expense to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'createdBy': createdBy.toIso8601String(),
    };
  }

  // Convert JSON to Expense
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      json['title'],
      json['price'].toDouble(),
      DateTime.parse(json['createdBy']),
    );
  }
}
