import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/details_post_screen.dart';

class Post extends StatefulWidget {
  final String url;
  final String tresc;
  final Timestamp data;
  final String user;
  final String urlUser;
  int ocena;

  Post({this.tresc, this.url, this.data, this.urlUser, this.user, this.ocena});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    var czas = widget.data.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(czas);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Center(
        child: Card(
          // elevation: 20,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.user,
                ),
                subtitle: Text(formattedDate),
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
                  style: TextStyle(fontSize: 15),
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
                      icon: Icon(Icons.message),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPostScreen(
                            data: widget.data,
                            ocena: widget.ocena,
                            tresc: widget.tresc,
                            url: widget.url,
                            user: widget.user,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            widget.ocena -= 1;
                          });
                        }),
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            widget.ocena++;
                          });
                        }),
                    Text(widget.ocena.toString()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
