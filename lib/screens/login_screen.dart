import "package:flutter/material.dart";
import './main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController login;
TextEditingController haslo;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    login = TextEditingController();
    haslo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("Nazwa portalu"),
            Image.asset(
              'assets/logo.png',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: login,
                decoration: InputDecoration(
                  hintText: "Podaj login",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: haslo,
                decoration: InputDecoration(
                  hintText: "Podaj haslo",
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MainScreen())),
              icon: Icon(Icons.double_arrow_sharp),
              label: Text("Zaloguj"),
            )
          ],
        ),
      ),
    );
  }
}
