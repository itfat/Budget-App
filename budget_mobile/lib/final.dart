import 'package:budget_mobile/globals.dart';
import 'package:flutter/material.dart';

class FinalList extends StatefulWidget {
  const FinalList({ Key? key }) : super(key: key);

  @override
  _FinalListState createState() => _FinalListState();
}

class _FinalListState extends State<FinalList> {
  @override


  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
        shrinkWrap: true,
          itemCount: DisplayList.length,
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
                          DisplayList[index].title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        value: DisplayList[index].isCheck,
                        // secondary: Container(
                        //   height: 50,
                        //   width: 50,
                        //   child: Image.asset(
                        //     DisplayList[index].img,
                        //     fit: BoxFit.cover,
                        //   ),
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
