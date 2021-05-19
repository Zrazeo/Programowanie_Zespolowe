import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/post.dart';
import './login_screen.dart';
import './post_screen.dart';
import 'dart:math' as math;
import './details_post_screen.dart';

import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool darkmode = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  var sort = false;

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forum'),
        actions: [
          IconButton(
            icon: Transform.rotate(
              child: Icon(Icons.compare_arrows_sharp),
              angle: math.pi / 2,
            ),
            onPressed: () {
              setState(() {
                sort = !sort;
                print(sort);
              });
            },
            tooltip: "Sortowanie",
          )
        ],
      ),
      drawer: Container(
        width: mediaQuery.width * 0.65,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(height: mediaQuery.height * 0.05),
              CircleAvatar(
                minRadius: 70,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(auth.currentUser.photoURL),
                // child: Image.network(
                //   auth.currentUser.photoURL,
                //   height: 90,
                //   width: 90,
              ),
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
                padding: EdgeInsets.only(top: 60),
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
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('ERROR');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                // print(document['zdj']);
                // print(document['post']);

                return Post(
                  user: document['uzytkownik'],
                  url: document['zdj'],
                  tresc: document['post'],
                  data: document['data'],
                  ocena: document['ocena'],
                );
              }).toList(),
            ),
          );
        },
        stream: sort
            ? posts.orderBy('data', descending: true).snapshots()
            : posts.orderBy('ocena', descending: true).snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostScreen()),
          );
        },
      ),
    );
  }
}
