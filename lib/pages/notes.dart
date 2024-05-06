import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> allNotes = [];
  //create an instance for the database hive
  final _noteBox = Hive.box("notes");
  NoteService noteService = NoteService();
  @override
  void initState() {
    //load the notes
    if (_noteBox.get("notes") == null) {
      noteService.createInitialNotes();

      //add notes to the allNotes
      setState(() {
        allNotes.addAll(noteService.allNotes);
        print(allNotes[0]);
      });
    } else {
      noteService.loadNotes();
      setState(() {
        allNotes.addAll(noteService.allNotes);
        print(allNotes[0]);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          children: [
            Text(
              'Notes',
              style: AppTextStyles.appTitle,
            ),
          ],
        ),
      ),
    );
  }
}
