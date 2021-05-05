import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import './main_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _login;
  String _haslo;
  String _email;
  final auth = FirebaseAuth.instance;

  bool czyLog = true;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          return Column(
            children: [
              SizedBox(
                height: czyLog
                    ? mediaQuery.height * 0.08
                    : mediaQuery.height * 0.15,
              ),
              czyLog
                  ? Image.asset(
                      'assets/logo.png',
                    )
                  : CircleAvatar(
                      minRadius: 50,
                      maxRadius: 50,
                      backgroundColor: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {
                          print('dziala');
                        },
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                        ),
                      ),
                    ),
              SizedBox(
                height: czyLog ? 0 : mediaQuery.height * 0.055,
              ),
              czyLog
                  ? SizedBox(
                      height: mediaQuery.height * 0.08,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Podaj nazwe użytkownika",
                        ),
                        onChanged: (value) {
                          setState(() {
                            _login = value.trim();
                          });
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Podaj e-mail",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Podaj haslo",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _haslo = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: mediaQuery.height * 0.015),
                child: FlatButton.icon(
                  onPressed: () async {
                    try {
                      czyLog
                          ? await auth.signInWithEmailAndPassword(
                              email: _email, password: _haslo)
                          : await auth.createUserWithEmailAndPassword(
                              email: _email, password: _haslo);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MainScreen()));
                    } on FirebaseAuthException catch (e) {
                      print(e.code);
                    }
                  },
                  icon: Icon(Icons.double_arrow_sharp),
                  label: Text(
                    czyLog ? "Zaloguj" : "Załóż konto",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              isKeyboardVisible
                  ? SizedBox()
                  : SizedBox(
                      height: mediaQuery.height * 0.2,
                    ),
              isKeyboardVisible
                  ? SizedBox()
                  : FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          czyLog = !czyLog;
                        });
                        print(czyLog);
                      },
                      icon: Icon(Icons.double_arrow_sharp),
                      label: Text(
                        czyLog
                            ? "Nie masz konta? Zarejestruj sie"
                            : 'Mam już konto. Zaloguj się',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }
}
