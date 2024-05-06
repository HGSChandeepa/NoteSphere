import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:brainbox/widgets/bottom_sheet.dart';
import 'package:brainbox/widgets/notes_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> allNotes = [];
  bool showCategoryInput = false;
  final _noteBox = Hive.box("notes");
  NoteService noteService = NoteService();

  void openBottomSheet() {
    showCategoryInput
        ? showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.6),
            builder: (context) => CategoryInputBottomSheet(
              showCategoryInput: true,
              onClose: () {
                setState(() {
                  showCategoryInput = false;
                });
              },
              onToggle: () {
                setState(() {
                  showCategoryInput = !showCategoryInput;
                });
              },
            ),
          )
        : showModalBottomSheet(
            context: context,
            barrierColor: Colors.black.withOpacity(0.6),
            builder: (context) => CategoryInputBottomSheet(
              showCategoryInput: false,
              onClose: () {
                setState(() {
                  showCategoryInput = false;
                });
              },
              onToggle: () {
                setState(() {
                  showCategoryInput = !showCategoryInput;
                });
              },
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    if (_noteBox.get("notes") == null) {
      noteService.createInitialNotes();
      setState(() {
        allNotes.addAll(noteService.allNotes);
      });
    } else {
      noteService.loadNotes();
      setState(() {
        allNotes.addAll(noteService.allNotes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        backgroundColor: AppColors.kFabColor,
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notes',
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppConstants.kDefaultPadding,
                mainAxisSpacing: AppConstants.kDefaultPadding,
                childAspectRatio: 6 / 4,
              ),
              itemCount: allNotes.length,
              itemBuilder: (context, index) {
                return NotesCard(
                  noteCategory: allNotes[index].category,
                  noOfNotes: noteService.getNoOfNotes(allNotes[index].category),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
