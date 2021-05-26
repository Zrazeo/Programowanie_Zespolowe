import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/post.dart';
import '../widgets/komentarz.dart';

class DetailsPostScreen extends StatelessWidget {
  final String id;
  final String url;
  final String tresc;
  final Timestamp data;
  final String user;
  final String urlUser;
  List<dynamic> komentarze;
  int ocena;
  final bool darkmode;

  DetailsPostScreen({
    this.id,
    this.tresc,
    this.url,
    this.data,
    this.urlUser,
    this.user,
    this.ocena,
    this.komentarze,
    this.darkmode,
  });

  TextEditingController textCon = TextEditingController();
  void sendHelp() {
    String url = auth.currentUser.photoURL;
    String nazwa = auth.currentUser.displayName;
    String tekst = textCon.text;
    Map mapka = {'URL': url, 'nazwa': nazwa, 'tekst': tekst};
    komentarze = [...komentarze, mapka];
    posts.doc(id).update({'komentarze': komentarze});
  }

  @override
  Widget build(BuildContext context) {
    // print(komentarze[0]);
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    return Scaffold(
      backgroundColor: darkmode ? Colors.black87 : Colors.white,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: darkmode ? Colors.black87 : Colors.white),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: ListView(
          children: [
            Post(
              data: data,
              ocena: ocena,
              tresc: tresc,
              url: url,
              user: user,
              darkmode: darkmode,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 246,
                child: Card(
                  elevation: 20,
                  child: ListView.builder(
                    itemCount: komentarze.length,
                    itemBuilder: (context, index) =>
                        Komentarz(komentarze, index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: darkmode ? Colors.blueGrey : Colors.white,
        // height: MediaQuery.of(context).size.height * 0.01,
        child: Row(
          children: [
            Container(
              color: darkmode ? Colors.blueGrey : Colors.white,
              width: MediaQuery.of(context).size.width * 0.87,
              child: TextField(
                onSubmitted: (_) {
                  sendHelp();
                  textCon.clear();
                },
                // maxLines: 20,
                controller: textCon,
                decoration: InputDecoration(
                  hintText: "Skomentuj",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  sendHelp();
                  textCon.clear();
                })
          ],
        ),
      ),
    );
  }
}
