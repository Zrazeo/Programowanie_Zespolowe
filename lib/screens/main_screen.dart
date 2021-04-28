import 'package:flutter/material.dart';
import './login_screen.dart';
import './profile_screen.dart';

import 'package:ionicons/ionicons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool darkmode = false;
  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'assets/avatar.png',
                  width: 65,
                  height: 65,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child: Text(
                    'Nazwa użytkownika',
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                    child: Text("Tu kiedys beda posty"),
                  ),
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
