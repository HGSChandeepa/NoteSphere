import 'package:brainbox/helpers/show_snackbar.dart';
import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;
  const UpdateNotePage({
    super.key,
    required this.note,
  });

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitileController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  String category = 'Work';
  List<String> categories = [];

  @override
  void dispose() {
    _noteTitileController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _noteTitileController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    category = widget.note.category;

    // Load all the categories
    _loadCategories();

    super.initState();
  }

  Future<void> _loadCategories() async {
    final noteService = NoteService();
    categories = await noteService.getAllCategories();
    setState(() {});
    print(categories.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: category,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        isExpanded: false,
                        hint: const Text(
                          'Category',
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppConstants.kDefaultPadding),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.1),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppConstants.kDefaultPadding),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor,
                              width: 1,
                            ),
                          ),
                        ),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerLeft,
                            value: category,
                            child: Text(
                              category,
                              style: AppTextStyles.appButton,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            category = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Note Title
                    TextFormField(
                      controller: _noteTitileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ), // Set text color to white
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ), // Set hint text color to white
                        border: InputBorder.none, // Remove all borders
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Note Content
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a content';
                        }
                        return null;
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ), // Set hint text color to white
                        border: InputBorder.none, // Remove all borders
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.kFabColor,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //save the note
                            if (_formKey.currentState!.validate()) {
                              try {
                                final NoteService noteService = NoteService();
                                //update the note
                                noteService.updateNote(
                                  //create a new note object
                                  Note(
                                    id: widget.note.id,
                                    title: _noteTitileController.text,
                                    content: _noteContentController.text,
                                    category: category,
                                    date: DateTime.now(),
                                  ),
                                );

                                //show a snackbar
                                AppHelpers.showSnackBar(
                                  context,
                                  'Note Updated successfully',
                                );

                                //clear the form
                                _noteTitileController.clear();
                                _noteContentController.clear();
                                AppRouter.router.push("/notes");
                              } catch (e) {
                                //show a snackbar
                                AppHelpers.showSnackBar(
                                  context,
                                  'Failed to update note',
                                );
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Update Note',
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
