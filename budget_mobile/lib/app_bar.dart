import 'package:flutter/material.dart';

class CustomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.pink,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/logo.jpg",
              height: 60,
              width: 60,
            ),
          ),
           SizedBox(
            width: 20,
          ),
          Text("Budget Planner",
          textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  
                  fontSize: 16)),

          // Column(
          //   children: [
          //     SizedBox(
          //       height: 20,
          //     ),
          //     ClipRRect(
          //       borderRadius: BorderRadius.circular(20),
          //       child: Image.asset(
          //         "assets/images/logo.jpg",

          //         height: 50,
          //         width: 50,
          //       ),
          //     ),
          //     ElevatedButton.icon(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.logout,
          //           size: 14,
          //           color: Colors.pink,
          //         ),
          //         label: Text("Logout", style: TextStyle(color: Colors.pink),),
          //         style: ElevatedButton.styleFrom(
          //           primary: Colors.white,

          //           minimumSize: Size(5, 20),
          //           shape: new RoundedRectangleBorder(
          //             borderRadius: new BorderRadius.circular(3.0),
          //           ),
          //         ))
          //   ],
          // ),
        ],
      ),
    );
  }
}
