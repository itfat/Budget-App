import 'package:flutter/material.dart';
import 'screens/sign_up/signup_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, SignUpScreen.routename),
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }
}
