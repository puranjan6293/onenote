import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onenotes/model/note.dart';

class NoteService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Note>> getNotes() async {
    QuerySnapshot snapshot = await _firestore.collection('notes').get();
    return snapshot.docs.map((doc) => Note.fromSnapshot(doc)).toList();
  }

  Future<String> addNote(Note note) async {
    DocumentReference docRef =
        await _firestore.collection('notes').add(note.toJson());
    return docRef.id;
  }

  Future<void> updateNote(Note note) async {
    await _firestore.collection('notes').doc(note.id).update(note.toJson());
  }

  Future<void> deleteNoteById(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }
}
