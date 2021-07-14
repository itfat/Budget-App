import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routename = "/SignUp";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line
      body: Body(),
    );
  }
}
