import 'package:brainbox/models/note_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  // Create the database reference for notes
  final _myBox = Hive.box("notes");

  // List of notes
  List<Note> allNotes = [];

  // Create the initial notes
  void createInitialNotes() {
    allNotes = [
      Note(
        id: const Uuid().v4(),
        title: "Meeting Notes",
        category: "Work",
        content:
            "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
        date: DateTime.now(),
      ),
      Note(
        id: const Uuid().v4(),
        title: "Grocery List",
        category: "Personal",
        content:
            "Bought milk, eggs, bread, fruits, and vegetables from the local grocery store. Also added some snacks for the week.",
        date: DateTime.now(),
      ),
      Note(
        id: const Uuid().v4(),
        title: "Book Recommendations",
        category: "Hobby",
        content:
            "Recently read 'Sapiens' by Yuval Noah Harari, which offered fascinating insights into the history of humankind. Also enjoyed 'Atomic Habits' by James Clear, a practical guide to building good habits and breaking bad ones.",
        date: DateTime.now(),
      ),
    ];
  }

  // Method to load the notes
  void loadNotes() async {
    final dynamic notes = await _myBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      allNotes = notes.cast<Note>().toList();
    }
  }

  // Method to add a note
  void addNote(Note note) async {
    allNotes.add(note);
    _myBox.put("notes", allNotes);
  }

  //methode to calculate the number of notes according to the category
  int getNoOfNotes(String category) {
    return allNotes.where((note) => note.category == category).length;
  }

  //method to get the notes according to the category
  List<Note> getNotesByCategory(String category) {
    return allNotes.where((note) => note.category == category).toList();
  }
}
