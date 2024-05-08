import 'package:brainbox/models/note_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  //all notes
  List<Note> allNotes = [
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
  // Create the database reference for notes
  final _myBox = Hive.box("notes");

  // Method to create the initial notes if the box is empty
  Future<void> createInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNotes);
    }
  }

  // Method to load the notes
  Future<List<Note>> loadNotes() async {
    final dynamic notes = await _myBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<Note>().toList();
    }
    return [];
  }

  // Method to add a note
  Future<void> addNote(Note note) async {
    try {
      //get all notes from the box
      final dynamic allNotes = await _myBox.get("notes");
      allNotes.add(note);
      await _myBox.put("notes", allNotes);
    } catch (e) {
      print(e);
    }
  }

  // Method to calculate the number of notes according to the category
  int getNoOfNotes(String category, List<Note> allNotes) {
    return allNotes.where((note) => note.category == category).length;
  }

  // Method to get all the categories
  Future<List<String>> getAllCategories() async {
    final List<String> categories = [];
    for (final note in allNotes) {
      if (!categories.contains(note.category)) {
        categories.add(note.category);
      }
    }
    return categories;
  }

  // Method to get the notes according to the category
  Future<List<Note>> getNotesByCategory(String category) async {
    //get all notes from the box
    final dynamic allNotes = await _myBox.get("notes");
    final List<Note> notes = [];
    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }

    return notes;
  }

  //loop througn all notes and create an object where the key is the category and the value is the notes in that category
  Map<String, List<Note>> getNotesByCategoryMap(List<Note> allNotes) {
    final Map<String, List<Note>> notesByCategory = {};
    for (final note in allNotes) {
      if (notesByCategory.containsKey(note.category)) {
        notesByCategory[note.category]!.add(note);
      } else {
        notesByCategory[note.category] = [note];
      }
    }
    return notesByCategory;
  }

  // Method to update / edit a note
  Future<void> updateNote(Note note) async {
    try {
      //get all notes from the box
      final dynamic allNotes = await _myBox.get("notes");
      final int index = allNotes.indexWhere((element) => element.id == note.id);
      allNotes[index] = note;
      await _myBox.put("notes", allNotes);
    } catch (e) {
      print(e);
    }
  }

  // Method to delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      //get all notes from the box
      final dynamic allNotes = await _myBox.get("notes");
      allNotes.removeWhere((element) => element.id == noteId);
      await _myBox.put("notes", allNotes);
    } catch (e) {
      print(e);
    }
  }
}
