import "package:flutter/material.dart";
import './main_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController login;
TextEditingController haslo;
TextEditingController email;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    login = TextEditingController();
    haslo = TextEditingController();
    email = TextEditingController();
  }

  bool czyLog = true;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
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
                        child: Image.asset('assets/avatar.png'),
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
                        controller: login,
                        decoration: InputDecoration(
                          hintText: "Podaj nazwe użytkownika",
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Podaj e-mail",
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
              Padding(
                padding: EdgeInsets.only(top: mediaQuery.height * 0.015),
                child: FlatButton.icon(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen())),
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
