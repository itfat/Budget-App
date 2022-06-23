import 'package:bb/cloud_expense.dart';
import 'package:flutter/material.dart';

typedef ExpenseCallback = void Function(CloudExpense expense);

class ExpenseListView extends StatelessWidget {
  final Iterable<CloudExpense> expenses;
  final ExpenseCallback onDeleteExpense;
  final ExpenseCallback onTap;

  const ExpenseListView({
    Key? key,
    required this.expenses,
    required this.onDeleteExpense,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses.elementAt(index);
          return ListTile(
            onTap: () {
              onTap(expense);
            },
            title: Text(expense.title),
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () async {
                // final shouldDelete = await showDeleteDialog(context);
                // if (shouldDelete) {
                onDeleteExpense(expense);
              },
            ),
            trailing: Text(
              expense.price.toString(),
            ),
          );
        });
  }
}
