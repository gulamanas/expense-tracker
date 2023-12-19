import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateExpenseDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController priceController;
  final int expenseIndex;
  final Function(String, double) onUpdate;

  const UpdateExpenseDialog({
    Key? key,
    required this.titleController,
    required this.priceController,
    required this.onUpdate,
    required this.expenseIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await _updateExpense(context);
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateExpense(BuildContext context) async {
    String title = titleController.text.trim();
    double price = double.tryParse(priceController.text.trim()) ?? 0.0;

    if (title.isNotEmpty && price > 0) {
      ExpenseProvider expenseProvider =
          Provider.of<ExpenseProvider>(context, listen: false);

      await expenseProvider.updateExpense(expenseIndex, title, price);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      // Show an error message or handle invalid input
    }
  }
}
