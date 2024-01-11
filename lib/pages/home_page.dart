import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/utils/add_expense_dialog.dart';
import 'package:expense_tracker/utils/update_expense_dialog.dart';
import 'package:expense_tracker/widgets/total_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<Expense> expenses = [
  //   Expense('Groceries', 50.0, DateTime(2023, 12, 17)),
  //   Expense('Dinner', 30.0, DateTime(2023, 12, 16)),
  //   Expense('Movie', 15.0, DateTime(2023, 12, 15)),
  //   // Add more expenses as needed
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expense Tracker'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const TotalContainer(),
          Expanded(
            child: Consumer<ExpenseProvider>(
              builder: (context, expenseProvider, _) {
                List<Expense> expenses = expenseProvider.expenses;
                return ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(expenses[index].title),
                      subtitle:
                          Text('₹${expenses[index].price.toStringAsFixed(2)}'),
                      trailing: Text(
                          'Created on: ${expenses[index].createdBy.toLocal().toString().split(' ')[0]}'),
                      leading: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showUpdateDialog(context, expenses[index], index);
                          }),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showUpdateDialog(BuildContext context, Expense expense, int index) {
    TextEditingController titleController =
        TextEditingController(text: expense.title);
    TextEditingController priceController =
        TextEditingController(text: expense.price.toString());
    TextEditingController categoryController =
        TextEditingController(text: expense.category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateExpenseDialog(
          titleController: titleController,
          priceController: priceController,
          categoryController: categoryController,
          expenseIndex: index,
          onUpdate: (p0, p1) {},
        );
      },
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExpenseDialog(
          onSave: (title, price) {},
        );
      },
    );
  }
}
