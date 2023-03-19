import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String body;

  Note({this.id = '', this.title = '', this.body = ''});

  factory Note.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Note(
      id: snapshot.id,
      title: data['title'],
      body: data['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
