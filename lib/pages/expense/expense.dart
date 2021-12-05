import 'package:flutter/material.dart';
import 'package:budgetium/pages/expense/add_expense.dart';

class Expense extends StatefulWidget {
  @override
  ExpensePageState createState() {
    return ExpensePageState();
  }
}

class ExpensePageState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return AddExpense();
            },
          );
        },
      ),
    );
  }
}
