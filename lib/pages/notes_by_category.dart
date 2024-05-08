import 'package:brainbox/helpers/show_snackbar.dart';
import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:brainbox/widgets/note_category_card.dart';

class NotesByCategoryPage extends StatefulWidget {
  final String category;
  const NotesByCategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<NotesByCategoryPage> createState() => _NotesByCategoryPageState();
}

class _NotesByCategoryPageState extends State<NotesByCategoryPage> {
  List<Note> noteList = [];
  @override
  void initState() {
    _loadCategoriesNotes();
    super.initState();
  }

  Future<void> _loadCategoriesNotes() async {
    final noteService = NoteService();
    noteList = await noteService.getNotesByCategory(widget.category);
    setState(() {});
  }

  //remove note
  Future<void> _removeNote(String id) async {
    try {
      await NoteService().deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note deleted successfully");
      }
    } catch (e) {
      print(e);
      AppHelpers.showSnackBar(context, "Failed to delete note");
    }
  }

  //edit note
  void _editNote(Note note) {
    //navigate to the edit note page
    AppRouter.router.push('/edit-note', extra: note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.category,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return NoteCategoryCard(
                    noteTitle: noteList[index].title,
                    noteContent: noteList[index].content,
                    removeNote: () async {
                      await _removeNote(noteList[index].id);
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      _editNote(noteList[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
