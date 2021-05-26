import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/post.dart';

class MyPost extends StatefulWidget {
  final bool darkmode;
  MyPost(this.darkmode);

  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  var sort = false;

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser.displayName;

    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    return Scaffold(
      backgroundColor: widget.darkmode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Moje posty',
          style:
              TextStyle(color: widget.darkmode ? Colors.black87 : Colors.white),
        ),
        iconTheme: IconThemeData(
            color: widget.darkmode ? Colors.black87 : Colors.white),
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
                print(document['komentarze']);
                // print(document['zdj']);
                // print(document['komentarze']);
                return auth == document['uzytkownik']
                    ? Post(
                        id: document.id,
                        user: document['uzytkownik'],
                        url: document['zdj'],
                        tresc: document['post'],
                        data: document['data'],
                        ocena: document['ocena'],
                        like: document['like'],
                        dislike: document['dislike'],
                        komentarze: document['komentarze'],
                        darkmode: widget.darkmode,
                      )
                    : SizedBox();
              }).toList(),
            ),
          );
        },
        stream: sort
            ? posts.orderBy('data', descending: true).snapshots()
            : posts.orderBy('ocena', descending: true).snapshots(),
      ),
    );
  }
}
