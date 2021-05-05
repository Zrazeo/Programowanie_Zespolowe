import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import "package:flutter/material.dart";
import './main_screen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

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

  File _image;
  final picker = ImagePicker();

  String downloadURL;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    Future<void> _uploadFile() async {
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('avatar/$_login.png')
            .putFile(_image);
        downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('avatar/$_login.png')
            .getDownloadURL();
        // print('jedynka'+downloadURL);
      } on firebase_core.FirebaseException catch (e) {
        print(e.message);
      }
    }

    Future<void> _addUser() {
      return _users
          .add({'email': _email, 'login': _login, 'url_zdjecia': downloadURL});
    }

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
                          getImage();
                        },
                        child: _image == null
                            ? Icon(
                                Icons.account_circle,
                                size: 100,
                              )
                            : Image.file(_image),
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
                      if (czyLog) {
                        await auth.signInWithEmailAndPassword(
                            email: _email, password: _haslo);
                      } else {
                        await auth.createUserWithEmailAndPassword(
                            email: _email, password: _haslo);
                        await _uploadFile();
                        await _addUser();
                        await auth.currentUser.updateProfile(
                            displayName: _login, photoURL: downloadURL);
                      }
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
