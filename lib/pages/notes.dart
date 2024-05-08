import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:brainbox/widgets/bottom_sheet.dart';
import 'package:brainbox/widgets/notes_card.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};
  final NoteService noteService = NoteService();

  void openBottomSheet() {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewNote: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: false);
          },
          onNewCategory: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: true);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    final Map<String, List<Note>> notesCategoryies =
        await noteService.getNotesByCategoryMap(loadedNotes);

    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesCategoryies;
    });
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
              itemCount: notesWithCategory.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AppRouter.router.push(
                      "/category",
                      extra: notesWithCategory.keys.elementAt(index),
                    );
                  },
                  child: NotesCard(
                    noteCategory: notesWithCategory.keys.elementAt(index),
                    noOfNotes: notesWithCategory.values.elementAt(index).length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
