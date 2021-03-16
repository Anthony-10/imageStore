import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_store/service/authentication.dart';


class Login extends StatefulWidget {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({Key key,
    this.auth,
    this.firestore
  }) : super(key: key);


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: const ValueKey("username"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: _emailField,
                ),
                TextFormField(
                  obscureText: true,
                  key: const ValueKey("password"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  controller: _passwordField,
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  key: const ValueKey("signIn"),
                  onPressed: () async {
                    final String retVal = await Auth(auth: widget.auth).signIn(
                      email: _emailField.text,
                      password: _passwordField.text,
                    );
                    if (retVal == "Success") {
                      _emailField.clear();
                      _passwordField.clear();
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(retVal),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign In"),
                ),
                FlatButton(
                  key: const ValueKey("createAccount"),
                  onPressed: () async {
                    final String retVal =
                    await Auth(auth: widget.auth).signUp(
                      email: _emailField.text,
                      password: _passwordField.text,
                    );
                    if (retVal == "Success") {
                      _emailField.clear();
                      _passwordField.clear();
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(retVal),
                        ),
                      );
                    }
                  },
                  child: const Text("Create Account"),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.fingerprint,
                    ),
                    iconSize: 60,
                    onPressed: () {
                      // _authenticate;
                    }),

                // InkWell(
                //   child: ListTile(
                //     onTap: () {},
                //     //title: Text('fingerprint'),
                //     leading: Icon(Icons.fingerprint),
                //   ),
                // ),

                //     Image.asset('assets/fingerprint.jpg',
                //       fit: BoxFit.cover,
                //       width: 120.0,
                // child: InkWell(
                // onTap: () { /* ... */ },
                // )
                //     ),
              ],
            );
          }),
        ),
      ),
    );
  }
}