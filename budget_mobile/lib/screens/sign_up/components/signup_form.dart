import 'dart:io';

import 'package:budget_mobile/form_errors.dart';
import 'package:budget_mobile/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants.dart';
import '../../../have_account.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String name;
  late String password;
  late String errorText;
  late File image;
  late String conform_password;
  bool circular = false;
  bool remember = false;

  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    // autoSignUp();
  }

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  _signUp() async {
    await Firebase.initializeApp();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user;
      user.updateProfile(displayName: name, photoURL: image.path);

      print(user.displayName);
      Navigator.pushReplacementNamed(context, LoginScreen.routename);
    } on FirebaseAuthException catch (e) {
      print('Email not valid.');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildNameFormField(),
              SizedBox(
                height: 20,
              ),
              buildEmailFormField(),
              SizedBox(height: 20),
              buildPasswordFormField(),
              SizedBox(height: 20),
              confirmPasswordFormField(),
              FormError(errors: errors),
              SizedBox(height: 20),
              // Text(((image.path.split("/").last))),
              Center(
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                    onPressed: () {
                      _showPicker(context);
                    },
                    icon: Icon(Icons.upload_file),
                    label: Text('Upload Cnic')),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _signUp();
                  }
                },
                child: Text(
                  'SignUp',
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
                  alignment:
                      Alignment.center, //set the button's child Alignment
                ),
              ),
              SizedBox(
                height: 30,
              ),
              HaveAccountText(),
            ],
          ),
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
          } else if (value.length <= 8) {
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
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.pink,
          //   ),
          // ),
        ));
  }

  TextFormField confirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password != conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Re-Enter Password",
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
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
        print(email);
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
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
        //   borderSide: BorderSide(
        //     color: Colors.pink,
        //   ),
        // ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        name = value;
        print("__________________________________________");
        print(name);
        print("__________________________________________");
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Name",
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
      ),
    );
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
      source: ImageSource
          .gallery, /* imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0 */
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }
}
