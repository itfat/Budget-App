import 'package:budget_mobile/income.dart';
import 'package:flutter/material.dart';
import 'package:budget_mobile/bottom.dart';

import '../../../final.dart';
import '../../../globals.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Card(
              color: Colors.pink[50],
              elevation: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Income:$b",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Total Expenses: $a",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )),
          FinalList(),
        ],
      ),
    ));
  }
}
