import 'package:budget_mobile/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
 

  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
 _signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.pink,
              // height: 800,
            ),
            child: Column(
              children: [
                new CircleAvatar(
                  radius: 50.0,
                  // backgroundColor: const Color(0xFF778899),
                  backgroundImage: AssetImage(
                    "assets/images/logo.jpg",
                    // fit: BoxFit.cover,
                  ), //For Image Asset
                ),

                // ),
                Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Follow Us',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Share',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Rate Us',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Log out',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                _signOut();
                // Update the state of the app.
                // ...
              },
            ),
          ),
        ],
      ),
    );
  }
}
