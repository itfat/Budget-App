import 'package:budget_mobile/income.dart';
import 'package:flutter/material.dart';
import 'package:budget_mobile/bottom.dart';

import '../../../final.dart';
import '../../../globals.dart';



class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SingleChildScrollView(
          child: Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Total Income:$a"), Text("Total Expenses: $b")],
          )),
        ),
        FinalList(),
      ],
    ));
  }
}
