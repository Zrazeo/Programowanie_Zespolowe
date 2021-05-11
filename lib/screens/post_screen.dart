import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  File _image;
  final picker = ImagePicker();
  String downloadURL;
  TextEditingController post = TextEditingController();

  final auth = FirebaseAuth.instance;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  CollectionReference _posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    Future<void> _uploadFile() async {
      DateTime now = DateTime.now();
      final String id =
          auth.currentUser.email + DateFormat('yyyy-MM-dd – kk:mm').format(now);
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('posts/$id.png')
            .putFile(_image);
        downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('posts/$id.png')
            .getDownloadURL();
      } on firebase_core.FirebaseException catch (e) {
        print(e.message);
      }
    }

    Future<void> _addPost() {
      DateTime now = DateTime.now();
      Timestamp data = Timestamp.fromDate(now);
      return _posts.add({
        'data': data,
        'uzytkownik': auth.currentUser.displayName,
        'zdj': downloadURL,
        'post': post.text,
        'ocena': 0,
        'komentarze': []
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("O czym myślisz?"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: post,
            decoration: InputDecoration(
                border: UnderlineInputBorder(), labelText: 'Tresc'),
          ),
          _image == null
              ? IconButton(
                  icon: Icon(Icons.image),
                  iconSize: 40.0,
                  tooltip: 'Dodaj zdjecie',
                  onPressed: () {
                    getImage();
                  },
                )
              : Image.file(
                  _image,
                  height: 200,
                  width: 200,
                ),
          FlatButton.icon(
            onPressed: () async {
              await _uploadFile();
              await _addPost();
              Navigator.pop(context);
            },
            label: Text("Wyślij"),
            icon: Icon(Icons.double_arrow_sharp),
          ),
        ],
      ),
    );
  }
}
