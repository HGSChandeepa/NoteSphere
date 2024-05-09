import 'package:brainbox/helpers/show_snackbar.dart';
import 'package:brainbox/models/todo_model.dart';
import 'package:brainbox/pages/todo_data_inharited.dart';
import 'package:brainbox/services/todo_service.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:brainbox/widgets/completed_todo_tab.dart';
import 'package:brainbox/widgets/todo_tab.dart';
import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage>
    with SingleTickerProviderStateMixin {
  late List<ToDo> allToDos = [];
  late List<ToDo> inCompleteToDos = [];
  late List<ToDo> completeToDos = [];
  late TabController _tabController;
  final TextEditingController _todoController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _todoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await ToDoService().isNewUser();

    if (isNewUser) {
      await ToDoService().createInitialTodos();
    }
    _loadToDos();
  }

  Future<void> _loadToDos() async {
    final List<ToDo> loadedToDos = await ToDoService().loadTodos();

    setState(() {
      allToDos = loadedToDos;
      inCompleteToDos = allToDos.where((todo) => !todo.isDone).toList();
      completeToDos = allToDos.where((todo) => todo.isDone).toList();
    });
  }

  void _addTodo() async {
    if (_todoController.text.isNotEmpty) {
      final ToDo newToDo = ToDo(
        title: _todoController.text,
        date: DateTime.now(),
        time: DateTime.now(),
        isDone: false,
      );

      try {
        await ToDoService().addTodo(newToDo);
        _loadToDos();
        final todosData = ToDoData.of(context);
        if (todosData != null) {
          todosData.onTodosChanged();
        }
        AppHelpers.showSnackBar(context, "Task Added");
        Navigator.pop(context);
      } catch (e) {
        AppHelpers.showSnackBar(context, "Failed to add task");
        print(e);
      }
    }
  }

  void openMessageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          title: Text(
            "Add Task",
            style: AppTextStyles.appDescription.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.kWhiteColor,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _todoController,
                  style: TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your task",
                    hintStyle: AppTextStyles.appDescriptionSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _addTodo();
                AppRouter.router.go("/todos");
              },
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
              child: const Text(
                "Add Task",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.kWhiteColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todosData = ToDoData.of(context);
    final todos = todosData?.todos ?? [];

    return ToDoData(
      todos: allToDos,
      onTodosChanged: _loadToDos,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AppRouter.router.go("/");
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  "ToDo",
                  style: AppTextStyles.appDescription,
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: AppTextStyles.appDescription,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openMessageModal(context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              side: BorderSide(
                color: AppColors.kWhiteColor,
                width: 2,
              )),
          backgroundColor: AppColors.kFabColor,
          child: Icon(
            Icons.add,
            color: AppColors.kWhiteColor,
            size: 30,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ToDoTab(
              inCompleteToDos: inCompleteToDos,
            ),
            CompletedTab(
              completeToDos: completeToDos,
            ),
          ],
        ),
      ),
    );
  }
}
