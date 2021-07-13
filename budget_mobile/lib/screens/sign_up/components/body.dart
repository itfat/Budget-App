import 'package:flutter/material.dart';
import 'signup_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 70),
          Image.asset(
            "assets/images/logo.jpg",
            height: 100,
            width: 100,
          ),
          SizedBox(height: 20),
          Text("Budget Planner",
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          SizedBox(height: 20),
          SignUpForm(),
        ],
      ),
    );
  }
}
