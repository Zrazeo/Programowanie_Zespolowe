import 'package:flutter/material.dart';
import './login_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Udostepnij cos na forum'),
            ),
            Text("Tu kiedys beda posty"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.logout),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()))),
    );
  }
}
