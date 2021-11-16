import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
String email = '';
String password = '';

void main() {
  runApp(Register());
}

class Register extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('images/Bus_Logo.png'),
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    letterSpacing: 2,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 300.0,
                  child: Divider(
                    color: Colors.amber,
                  ),
                ),
                Card(
                  color: Colors.amber,
                  margin:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      size: 30.0,
                      color: Colors.black87,
                    ),
                    title: TextField(),
                  ),
                ),
                Card(
                  color: Colors.amber,
                  margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 50.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 30.0,
                      color: Colors.black87,
                    ),
                    title: TextField(),
                  ),
                ),
                Card(
                  color: Colors.amber,
                  margin:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.password,
                      size: 30.0,
                      color: Colors.black87,
                    ),
                    title: TextField(),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

//segitseg a containerekhez
//https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

//https://kickertech.com/login-and-register-easily-with-flutter-using-firebase/