import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseDialog extends StatefulWidget {
  final Function(String, double) onSave;

  const AddExpenseDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  AddExpenseDialogState createState() => AddExpenseDialogState();
}

class AddExpenseDialogState extends State<AddExpenseDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expense'),
      content: SizedBox(
        height: 150,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _saveExpense(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveExpense(BuildContext context) {
    String title = titleController.text.trim();
    double price = double.tryParse(priceController.text.trim()) ?? 0.0;

    if (title.isNotEmpty && price > 0) {
      ExpenseProvider expenseProvider =
          Provider.of<ExpenseProvider>(context, listen: false);

      expenseProvider.saveExpense(title, price);

      // Close the dialog
      Navigator.of(context).pop();
    } else {
      // Show an error message or handle invalid input
    }
  }
}
