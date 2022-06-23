import 'package:bb/auth/auth_service.dart';
import 'package:bb/cloud_expense.dart';
import 'package:bb/firebase_cloud_storage.dart';
import 'package:bb/views/home_screen/components/expenses_list.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final FirebaseCloudStorage _expensesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _expensesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allexpenses = snapshot.data as Iterable<CloudExpense>;
                return ExpenseListView(
                  expenses: allexpenses,
                  onDeleteExpense: (expense) async {
                    await _expensesService.deleteExpense(
                        documentId: expense.documentId);
                  },
                  onTap: (CloudExpense expense) {
                    // Navigator.of(context).pushNamed(
                    //   createOrUpdateExpenseRoute,
                    //   arguments: expense,
                    // );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }

            default:
              return const CircularProgressIndicator();
          }
        }),
        stream: _expensesService.allexpenses(ownerUserId: userId));
  }
}
