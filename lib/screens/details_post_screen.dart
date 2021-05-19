import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/post.dart';

class DetailsPostScreen extends StatelessWidget {
  final String url;
  final String tresc;
  final Timestamp data;
  final String user;
  final String urlUser;
  int ocena;

  DetailsPostScreen(
      {this.tresc, this.url, this.data, this.urlUser, this.user, this.ocena});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: ListView(
          children: [
            Post(data: data, ocena: ocena, tresc: tresc, url: url, user: user),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 246,
                child: Card(
                  elevation: 20,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://scontent.fktw4-1.fna.fbcdn.net/v/t1.18169-9/1459301_378801605584271_968602413_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=_JTgmQJ6FwEAX-TVw8d&_nc_ht=scontent.fktw4-1.fna&oh=3cd8f9184303c1af7dc3745efdaef2ec&oe=60CBFE28'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Użytkwonik'),
                                Text(
                                  '5 dni temu',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Text(
                            'Lorem Ipsum has been the industry\'s a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        // height: MediaQuery.of(context).size.height * 0.01,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.87,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.send), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
