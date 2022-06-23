import 'package:budget_mobile/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  _IncomeListState createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  final _formKey = GlobalKey<FormState>();
  bool once = false;
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
  sumMoney() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("b", b);
  }

  var prix;
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
          shrinkWrap: true,
          itemCount: checkBoxListTileModel.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: Column(children: <Widget>[
                    new CheckboxListTile(
                        activeColor: Colors.pink[300],
                        dense: true,
                        //font change
                        title: new Text(
                          checkBoxListTileModel[index].title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        value: checkBoxListTileModel[index].isCheck,
                        onChanged: (val) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Stack(
                                  // overflow: Overflow.visible,
                                  children: <Widget>[
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.pink,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: getPrice(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .pink, //button's fill color
                                                shadowColor: Colors
                                                    .black, //specify the button's elevation color
                                                elevation:
                                                    4.0, //buttons Material shadow
                                                minimumSize: Size(100,
                                                    40), //specify the button's first: width and second: height
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35.0)), // set the buttons shape. Make its birders rounded etc
                                                enabledMouseCursor: MouseCursor
                                                    .defer, //used to construct ButtonStyle.mouseCursor
                                                disabledMouseCursor: MouseCursor
                                                    .uncontrolled, //used to construct ButtonStyle.mouseCursor
                                                visualDensity: VisualDensity(
                                                    horizontal: 0.0,
                                                    vertical:
                                                        0.0), //set the button's visual density
                                                tapTargetSize: MaterialTapTargetSize
                                                    .padded, // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                                                animationDuration: Duration(
                                                    milliseconds:
                                                        100), //the buttons animations duration
                                                enableFeedback:
                                                    true, //to set the feedback to true or false
                                                alignment: Alignment
                                                    .center, //set the button's child Alignment
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                              });
                          itemChange(val!, index);
                        })
                  ])),
            );
          }),
    );
  }

  getPrice() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        setState(() {
          if (once) {
            prix = int.parse(newValue!);
            assert(prix is int);
            print(prix);
            prices.add(prix);
            b += prix;
            once = false;
          }
        });
      },
      validator: (value) {
        if (value!.isEmpty) return "Price can not be empty";
        return null;
      },
      decoration: InputDecoration(
        labelText: "Price",
        focusColor: Colors.pink,
        hintText: "Enter Price",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
      if (checkBoxListTileModel[index].isCheck == true &&
          !titles.contains(checkBoxListTileModel[index].title)) {
        once = true;
        print("Price is+++++++++++++++++++++++++++++++++" + prix.toString());
        titles.add(checkBoxListTileModel[index].title);
        icons.add(
          CircleAvatar(
            radius: 10,
            child: Icon(
              MyFlutterApp.plus,
              size: 14,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }
}

class CheckBoxListTileModel {
  int userId;
  // String img;
  String title;
  bool isCheck;

  CheckBoxListTileModel(
      {required this.userId,
      /* required this.img, */ required this.title,
      required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          userId: 1,
          // img: 'assets/images/android_img.png',
          title: "Salary",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 2,
          // img: 'assets/images/flutter.jpeg',
          title: "Refunds",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 3,
          // img: 'assets/images/ios_img.webp',
          title: "Rental",
          isCheck: false),
      CheckBoxListTileModel(
          userId: 4,
          // img: 'assets/images/php_img.png',
          title: "Grants",
          isCheck: false),
    ];
  }
}
