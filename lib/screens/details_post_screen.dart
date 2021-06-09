import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/post.dart';
import '../widgets/komentarz.dart';
import 'package:intl/intl.dart';

class DetailsPostScreen extends StatefulWidget {
  final String id;
  final String url;
  final String tresc;
  final Timestamp data;
  final String user;
  final String urlUser;
  List<dynamic> komentarze;
  int ocena;
  final bool darkmode;
  List<dynamic> like;
  List<dynamic> dislike;
  Function upvote;
  Function downvote;

  DetailsPostScreen(
      {this.id,
      this.tresc,
      this.url,
      this.data,
      this.urlUser,
      this.user,
      this.ocena,
      this.komentarze,
      this.darkmode,
      this.like,
      this.dislike,
      this.upvote,
      this.downvote});

  @override
  _DetailsPostScreenState createState() => _DetailsPostScreenState();
}

class _DetailsPostScreenState extends State<DetailsPostScreen> {
  TextEditingController textCon = TextEditingController();

  void sendHelp() {
    String url = auth.currentUser.photoURL;
    String nazwa = auth.currentUser.displayName;
    String tekst = textCon.text;
    Map mapka = {'URL': url, 'nazwa': nazwa, 'tekst': tekst};
    widget.komentarze = [...widget.komentarze, mapka];
    posts.doc(widget.id).update({'komentarze': widget.komentarze});
  }

  @override
  Widget build(BuildContext context) {
    // print("WTF");

    var czas = widget.data.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(czas);
    return Scaffold(
      backgroundColor: widget.darkmode ? Colors.blueGrey[900] : Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: widget.darkmode ? Colors.black87 : Colors.white),
      ),
      body: Container(
        color: widget.darkmode ? Colors.blueGrey[900] : Colors.white,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Card(
          color: widget.darkmode ? Colors.blueGrey[900] : Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    widget.user,
                    style: TextStyle(
                        color: widget.darkmode ? Colors.white : Colors.black87),
                  ),
                  subtitle: Text(
                    formattedDate,
                    style: TextStyle(
                        color:
                            widget.darkmode ? Colors.white70 : Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(widget.url,
                      width: 150, height: 150, fit: BoxFit.fill),
                ),
                ListTile(
                  title: Text(
                    widget.tresc,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        color: widget.darkmode ? Colors.white : Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                ),
                Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () async {
                          int zmienna;
                          if (widget.dislike.contains(auth.currentUser.email) &&
                              (widget.like.contains(auth.currentUser.email) ==
                                  false)) {
                            zmienna = 1; // z nie lubisz na nic
                          } else if (widget.like
                              .contains(auth.currentUser.email)) {
                            zmienna = -2; // z lubisz na nie lubisz
                          } else if ((widget.like
                                      .contains(auth.currentUser.email)) ==
                                  false &&
                              (widget.dislike
                                      .contains(auth.currentUser.email)) ==
                                  false) {
                            zmienna = -1; // z nic na lubisz
                          }
                          setState(() {
                            widget.ocena += zmienna;
                          });
                          await widget.downvote(zmienna);
                          // widget.ocena -= 1;
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          // print(widget.id);
                          int zmienna;
                          if (widget.like.contains(auth.currentUser.email)) {
                            zmienna = -1; // z lubisz na nic
                          } else if (widget.dislike
                              .contains(auth.currentUser.email)) {
                            zmienna = 2; // z nie lubisz na lubisz
                          } else if ((widget.like
                                      .contains(auth.currentUser.email)) ==
                                  false &&
                              (widget.dislike
                                      .contains(auth.currentUser.email)) ==
                                  false) {
                            zmienna = 1; // z nic na lubisz

                          }
                          setState(() {
                            widget.ocena += zmienna;
                          });
                          await widget.upvote(zmienna);

                          // widget.ocena++;
                        },
                      ),
                      Text("${widget.ocena}"),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 246,
                      child: Card(
                        color: widget.darkmode
                            ? Colors.blueGrey[900]
                            : Colors.white,
                        elevation: 20,
                        child: ListView.builder(
                          itemCount: widget.komentarze.length,
                          itemBuilder: (context, index) => Komentarz(
                              widget.komentarze, index, widget.darkmode),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: widget.darkmode ? Colors.blueGrey : Colors.white,
                  // height: MediaQuery.of(context).size.height * 0.01,
                  child: Row(children: [
                    Container(
                      color: widget.darkmode ? Colors.blueGrey : Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextField(
                        onSubmitted: (_) {
                          sendHelp();
                          textCon.clear();
                        },
                        // maxLines: 20,
                        controller: textCon,
                        decoration: InputDecoration(
                          hintText: "Skomentuj",
                          hintStyle: TextStyle(
                              color: widget.darkmode
                                  ? Colors.white
                                  : Colors.black),
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
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
