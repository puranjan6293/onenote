import 'package:flutter/material.dart';
import 'package:onenotes/model/note.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteEditScreen extends StatefulWidget {
  final Note note;

  const NoteEditScreen({super.key, required this.note});

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title;
    _bodyController.text = widget.note.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Contacts',
          style: GoogleFonts.pacifico(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: GoogleFonts.lato(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  hintText: 'Contact Number',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  Note note = widget.note;
                  note.title = _titleController.text;
                  note.body = _bodyController.text;
                  Navigator.pop(context, note);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
