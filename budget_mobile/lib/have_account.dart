import 'package:budget_mobile/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, LoginScreen.routename),
          child: Text(
            "Login",
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
