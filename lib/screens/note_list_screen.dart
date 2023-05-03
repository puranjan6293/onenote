import 'package:flutter/material.dart';
import 'package:onenotes/model/note.dart';
import 'package:onenotes/screens/note_edit_screen.dart';
import 'package:onenotes/services/note_service.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> _notes = [];
  final NoteService _noteService = NoteService();

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
        elevation: 0,
        title: Text(
          'Contacts',
          style: GoogleFonts.pacifico(),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                _notes[index].title,
                style: GoogleFonts.poppins(),
              ),
              subtitle: Text(
                _notes[index].body,
                style: GoogleFonts.firaSans(),
              ),
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
