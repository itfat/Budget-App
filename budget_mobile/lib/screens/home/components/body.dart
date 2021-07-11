import 'package:budget_mobile/income.dart';
import 'package:flutter/material.dart';
import 'package:budget_mobile/bottom.dart';
class Body extends StatelessWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child:SizedBox(child: Text("Total Income:1000"),),
    ),
      );
  }
}