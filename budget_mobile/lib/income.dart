import 'package:flutter/material.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  _IncomeListState createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  @override
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();

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
                child: Column(
                  children: <Widget>[
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
                        // secondary: Container(
                        //   height: 50,
                        //   width: 50,
                          // child: Image.asset(
                          //   checkBoxListTileModel[index].img,
                          //   fit: BoxFit.cover,
                          // ),
                        // ),
                        onChanged: (val) {
                          itemChange(val!, index);
                        })
                  ],
                ),
              ),
            );
          }),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
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
