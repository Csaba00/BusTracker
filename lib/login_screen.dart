import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
String email = '';
String password = '';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('images/Bus_Logo.png'),
            ),
            Text(
              'Bus Tracker',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.amber,
              ),
            ),
            SizedBox(
              height: 20,
              width: 150,
              child: Divider(
                color: Colors.amber,
              ),
            ),
            Card(
              color: Colors.amber,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.grey.shade900,
                ),
                title: Container(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Enter your email'),
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontFamily: 'SourceSansPro',
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.amber,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                leading: Icon(
                  Icons.password,
                  color: Colors.grey.shade900,
                ),
                title: Container(
                  height: 50,
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                        const InputDecoration(labelText: 'Enter your password'),
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontFamily: 'SourceSansPro',
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        //Go to register screen.
                        Navigator.pushNamed(context, '/register');
                      },
                      minWidth: 120.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.grey.shade900,
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          await Navigator.pushNamed(
                              context, '/login/Googlemaps');
                          //Go to login screen.
                        } on FirebaseAuthException catch (e) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                  title: Text("Ops! Login Failed"),
                                  content: Text('${e.message}')));
                        };
                      },
                      minWidth: 120.0,
                      height: 42.0,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.grey.shade900,
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
