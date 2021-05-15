import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Post extends StatelessWidget {
  final String url;
  final String tresc;
  final Timestamp data;

  Post({this.tresc, this.url, this.data});

  @override
  Widget build(BuildContext context) {
    var czas = data.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(czas);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Card(
          elevation: 20,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(url,
                    width: 150, height: 150, fit: BoxFit.fill),
              ),
              ListTile(
                title: Text(
                  tresc,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(formattedDate, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
