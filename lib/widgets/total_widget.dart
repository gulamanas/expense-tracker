import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalContainer extends StatelessWidget {
  const TotalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double totalAmount = Provider.of<ExpenseProvider>(context).getTotalAmount();
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: Colors.purpleAccent[400],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total:',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            '₹ ${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
