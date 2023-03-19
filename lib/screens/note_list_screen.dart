import 'package:flutter/material.dart';
import 'package:onenotes/model/note.dart';
import 'package:onenotes/screens/note_edit_screen.dart';
import 'package:onenotes/services/note_service.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> _notes = [];
  NoteService _noteService = NoteService();

  @override
  void initState() {
    super.initState();
    _noteService.getNotes().then((notes) {
      setState(() {
        _notes = notes;
      });
    });
  }

  //add note
  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NoteEditScreen(
                note: Note(),
              )),
    ).then((note) {
      if (note != null) {
        _noteService.addNote(note).then((id) {
          note.id = id;
          setState(() {
            _notes.add(note);
          });
        });
      }
    });
  }

  //edit or update
  void _editNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditScreen(note: note)),
    ).then((editedNote) {
      if (editedNote != null) {
        _noteService.updateNote(editedNote).then((_) {
          setState(() {
            _notes[_notes.indexWhere((n) => n.id == note.id)] = editedNote;
          });
        });
      }
    });
  }

  //delete note
  void _deleteNoteById(String id) {
    _noteService.deleteNoteById(id).then((_) {
      setState(() {
        _notes.removeWhere((note) => note.id == id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_notes[index].title),
              subtitle: Text(_notes[index].body),
              onTap: () {
                _editNote(_notes[index]);
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteNoteById(_notes[index].id);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
