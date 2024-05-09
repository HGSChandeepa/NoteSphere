import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/models/todo_model.dart';
import 'package:brainbox/pages/todo_data_inharited.dart';
import 'package:brainbox/services/note_service.dart';
import 'package:brainbox/services/todo_service.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:brainbox/widgets/main_screen_todo_card.dart';
import 'package:brainbox/widgets/notes_todo_card.dart';
import 'package:brainbox/widgets/progress_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> allNotes = [];
  List<ToDo> allToDos = [];

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
    setState(() {});
  }

  void _checkIfUserIsNew() async {
    // Check if the notes box is empty
    final bool isNewUser =
        await NoteService().isNewUser() || await ToDoService().isNewUser();
    if (isNewUser) {
      // If the user is new, create the initial notes
      await NoteService().createInitialNotes();
      await ToDoService().createInitialTodos();
    }
    // Load the notes
    _loadNotes();
    _loadToDos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteService().loadNotes();

    setState(() {
      allNotes = loadedNotes;
      print(allNotes.length);
    });
  }

  Future<void> _loadToDos() async {
    final List<ToDo> loadedToDos = await ToDoService().loadTodos();

    setState(() {
      allToDos = loadedToDos;
      print(allToDos.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      allToDos.sort((a, b) => a.date.compareTo(b.date));
    });

    return ToDoData(
      todos: allToDos,
      onTodosChanged: _loadToDos,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NoteSphere',
            style: AppTextStyles.appTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ProgressCard(
                completedTasks: allToDos.where((todo) => todo.isDone).length,
                totalTasks: allToDos.length,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    //go to notes page using gorouter
                    onTap: () {
                      AppRouter.router.push("/notes");
                    },
                    child: NotesTodoCard(
                      title: 'Notes',
                      description: "${allNotes.length.toString()} Notes",
                      icon: Icons.bookmark_add_outlined,
                    ),
                  ),
                  GestureDetector(
                    //go to todo page using gorouter
                    onTap: () {
                      AppRouter.router.push("/todos");
                    },
                    child: NotesTodoCard(
                      title: 'To-Do List',
                      description: "${allToDos.length.toString()} Tasks",
                      icon: Icons.today_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Progress",
                    style: AppTextStyles.appSubtitle,
                  ),
                  Text(
                    "See All",
                    style: AppTextStyles.appButton,
                  ),
                ],
              ),
              // Add the progress card here
              const SizedBox(height: 20),
              //display all  todos
              Expanded(
                child: ListView.builder(
                  itemCount: allToDos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MainScreenToDoCard(
                        toDoTitle: allToDos[index].title,
                        date: allToDos[index].date.toString(),
                        time: allToDos[index].time.toString(),
                        isDone: allToDos[index].isDone,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
