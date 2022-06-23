import 'package:bb/auth/auth_service.dart';
import 'package:bb/cloud_expense.dart';
import 'package:bb/firebase_cloud_storage.dart';
import 'package:bb/utilities/generics/get_arguments.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class CreateUpdateExpenseView extends StatefulWidget {
  const CreateUpdateExpenseView({Key? key}) : super(key: key);

  @override
  State<CreateUpdateExpenseView> createState() => _CreateUpdateExpenseViewState();
}

class _CreateUpdateExpenseViewState extends State<CreateUpdateExpenseView> {
  CloudExpense? _expense;
  late final FirebaseCloudStorage _expensesService;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _expensesService = FirebaseCloudStorage();
    _textEditingController = TextEditingController();
  }

  void _textControllerListener() async {
    final expense = _expense;
    if (expense == null) {
      return;
    }
    final text = _textEditingController.text;
    await _expensesService.updateExpense(
      documentId: expense.documentId,
      text: text,
    );
  }

  void _setUptextControllerListener() async {
    _textEditingController.removeListener(() {
      _textControllerListener();
    });
    _textEditingController.addListener(() {
      _textControllerListener();
    });
  }

  Future<CloudExpense> createOrGetExistingexpense() async {
    final widgetexpense = context.getArgument<CloudExpense>();
    if (widgetexpense != null) {
      _expense = widgetexpense;
      _textEditingController.text = widgetexpense.text;
      return widgetexpense;
    }

    final existingexpense = _expense;
    if (existingexpense != null) {
      return existingexpense;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newexpense = await _expensesService.createNewExpense(ownerUserId: userId);
    _expense = newexpense;
    return newexpense;
  }

  Future<void> _saveexpenseIfTextexpensempty() async {
    final expense = _expense;
    final text = _textEditingController.text;
    if (text.isExpensEmpty && expense != null) {
      await _expensesService.updateExpense(
        documentId: expense.documentId,
        text: text,
      );
    }
  }

  void _deleteexpenseIfTextIsEmpty() {
    final expense = _expense;
    if (_textEditingController.text.isEmpty && expense != null) {
      _expensesService.deleteExpense(documentId: expense.documentId);
    }
  }

  @override
  void dispose() {
    _deleteexpenseIfTextIsEmpty();
    _saveexpenseIfTextexpensempty();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New expense"),
        actions: [
          IconButton(
              onPressed: () async {
                final text = _textEditingController.text;
                // if (_expense == null || text.isEmpty) {
                //   await showCannotShareEmptyexpenseDialog(context);
                // } else {
                //   Share.share(text);
                // }
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingexpense(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setUptextControllerListener();
              return TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Start typing your expense",
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
