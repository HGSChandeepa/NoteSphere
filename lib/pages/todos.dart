import 'package:brainbox/models/todo_model.dart';
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
  List<ToDo> allToDos = [];
  List<ToDo> inCompleteToDos = [];
  List<ToDo> completeToDos = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    // Check if the notes box is empty
    final bool isNewUser = await ToDoService().isNewUser();

    if (isNewUser) {
      // If the user is new, create the initial notes
      await ToDoService().createInitialTodos();
    }
    // Load the notes
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

  // Add the openBottomSheet method here
  void openBottomSheet() {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: AppColors.kCardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text("Add Task",
                    style: AppTextStyles.appDescription.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your task",
                    hintStyle: AppTextStyles.appDescriptionSmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
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
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppRouter.router.go(
              "/",
            );
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
        onPressed: openBottomSheet,
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
    );
  }
}
