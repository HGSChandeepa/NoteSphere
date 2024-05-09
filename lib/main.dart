import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/models/todo_model.dart';
import 'package:brainbox/pages/todo_data_inharited.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  //adapters registration
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ToDoAdapter());

  // Open Hive box
  await Hive.openBox('notes');
  await Hive.openBox('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToDoData(
      todos: [],
      onTodosChanged: () {},
      child: MaterialApp.router(
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeClass.darkTheme.copyWith(
          textTheme: GoogleFonts.dmSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
