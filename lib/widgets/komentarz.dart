import 'package:flutter/material.dart';

class Komentarz extends StatelessWidget {
  List<dynamic> komentarze;
  final int indeks;

  Komentarz(this.komentarze, this.indeks);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                Text(komentarze[indeks]['nazwa']),
                Text(
                  '3 dni temu',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Text(komentarze[indeks]['tekst']),
      ),
    ]);
  }
}
