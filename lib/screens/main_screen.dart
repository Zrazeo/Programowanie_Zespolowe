import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './login_screen.dart';

import 'package:ionicons/ionicons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool darkmode = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forum'),
      ),
      drawer: Container(
        width: mediaQuery.width * 0.65,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(height: mediaQuery.height * 0.05),
              CircleAvatar(
                  minRadius: 40,
                  backgroundColor: Colors.transparent,
                  child: Image.network(
                    auth.currentUser.photoURL,
                    height: 90,
                    width: 90,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    auth.currentUser.displayName,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: ListTile(
                  leading: Icon(Icons.message),
                  title: Text(
                    'Moje posty',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    darkmode = !darkmode;
                  });
                  print(auth.currentUser);
                },
                child: ListTile(
                  leading: Icon(darkmode ? Ionicons.moon : Ionicons.sunny),
                  title: Text(
                    darkmode ? 'Tryb ciemny' : 'Tryb jasny',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.37,
              ),
              GestureDetector(
                onTap: () {
                  auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Wyloguj',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text("Tu kiedys beda posty"),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Udostepnij cos na forum'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
