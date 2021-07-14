import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  static String routename = "/login";
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,   //new line
      body: Body(),
      
    );
  }
}