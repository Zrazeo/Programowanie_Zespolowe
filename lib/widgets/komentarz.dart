import 'package:flutter/material.dart';

class Komentarz extends StatelessWidget {
  List<dynamic> komentarze;
  final int indeks;
  final bool darkmode;

  Komentarz(this.komentarze, this.indeks, this.darkmode);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkmode ? Colors.blueGrey[900] : Colors.white,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(komentarze[indeks]['URL']),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    komentarze[indeks]['nazwa'],
                    style:
                        TextStyle(color: darkmode ? Colors.white : Colors.grey),
                  ),
                  Text(
                    '3 dni temu',
                    style:
                        TextStyle(color: darkmode ? Colors.white : Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            komentarze[indeks]['tekst'],
            style: TextStyle(color: darkmode ? Colors.white : Colors.grey),
          ),
        ),
      ]),
    );
  }
}
