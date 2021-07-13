import 'package:budget_mobile/screens/home/home_screen.dart';
import 'package:budget_mobile/screens/sign_up/signup_screen.dart';
import 'package:flutter/widgets.dart';

import 'screens/login/login_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routename: (context) => LoginScreen(),
  SignUpScreen.routename: (context) => SignUpScreen(),
  HomeScreen.routename: (context) => HomeScreen(),
};

