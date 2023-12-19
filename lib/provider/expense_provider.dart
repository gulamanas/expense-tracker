import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('expenses') ?? '[]';

    _expenses = Expense.listFromJson(data);
    notifyListeners();
  }

  Future<void> saveExpense(String title, double price) async {
    _expenses.add(Expense(title, price, DateTime.now()));
    await _saveExpenses();
    notifyListeners();
  }

  Future<void> _saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = Expense.listToJson(_expenses);
    await prefs.setString('expenses', data);
  }

  Future<void> updateExpense(int index, String title, double price) async {
    DateTime originalDate = _expenses[index].createdBy;
    _expenses[index] = Expense(title, price, originalDate);
    await _saveExpenses();
    notifyListeners();
  }

  double getTotalAmount() {
    return _expenses.map((expense) => expense.price).fold(0.0, (a, b) => a + b);
  }
}
