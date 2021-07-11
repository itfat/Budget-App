import 'package:budget_mobile/app_bar.dart';
import 'package:budget_mobile/bottom.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/drawer.dart';

class HomeScreen extends StatelessWidget {
  static String routename = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Budget Planner"),
      backgroundColor: Colors.pink,),
      body:  Body(),
      bottomNavigationBar: CustomBottom(),
      drawer: Container(child: HomeDrawer() ,color: Colors.white),
    );
  }
}
