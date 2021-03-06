import 'package:budget_mobile/screens/home/home_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../form_errors.dart';
import '../../../no_account.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String errorText;

  final List<String> errors = [];

  @override
  void initState() {
    super.initState(); 
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  login() async {
    await Firebase.initializeApp();

    try {
      print(email);
      print(password);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, HomeScreen.routename);
    } 
    

    

    // Existing and future Auth states are now persisted in the current
    // session only. Closing the window would clear any existing state even
    // if a user forgets to sign out.
    // ...
    // New sign-in will be persisted with session persistence.
    
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: 20),
            buildPasswordFormField(),
            SizedBox(height: 20),
            FormError(
              errors: errors,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(errors);
                  login();
                }
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink, //button's fill color
                shadowColor:
                    Colors.black, //specify the button's elevation color
                elevation: 4.0, //buttons Material shadow
                minimumSize: Size(100,
                    40), //specify the button's first: width and second: height
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        35.0)), // set the buttons shape. Make its birders rounded etc
                enabledMouseCursor: MouseCursor
                    .defer, //used to construct ButtonStyle.mouseCursor
                disabledMouseCursor: MouseCursor
                    .uncontrolled, //used to construct ButtonStyle.mouseCursor
                visualDensity: VisualDensity(
                    horizontal: 0.0,
                    vertical: 0.0), //set the button's visual density
                tapTargetSize: MaterialTapTargetSize
                    .padded, // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                animationDuration: Duration(
                    milliseconds: 100), //the buttons animations duration
                enableFeedback: true, //to set the feedback to true or false
                alignment: Alignment.center, //set the button's child Alignment
              ),
            ),
            SizedBox(height: 20),
            NoAccountText(),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;

        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Colors.pink,
        //   ),
        // ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
        print(email);
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,

        // focusedBorder: OutlineInputBorder(

        // borderRadius: BorderRadius.all(Radius.circular(4.0)),
        // borderSide: BorderSide(
        //   color: Colors.pink,
        // ),
        // ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(
        //   svgIcon: "assets/icons/Mail.svg",
        // ),
      ),
    );
  }
}
