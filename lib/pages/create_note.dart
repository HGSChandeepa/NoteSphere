import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  List<String> categories = [];

  @override
  void initState() {
    //load all the categories
    setState(() {
      categories = NoteService().getAllCategories();
    });
    super.initState();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
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
                          // Update the selected category
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
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
                    TextField(
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
                    ElevatedButton(
                      onPressed: () {
                        //save the note
                      },
                      child: const Text('Save'),
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
