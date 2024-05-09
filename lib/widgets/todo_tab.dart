import 'package:brainbox/helpers/show_snackbar.dart';
import 'package:brainbox/models/todo_model.dart';
import 'package:brainbox/pages/todo_data_inharited.dart';
import 'package:brainbox/services/todo_service.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/router.dart';
import 'package:brainbox/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class ToDoTab extends StatefulWidget {
  final List<ToDo> inCompleteToDos;
  const ToDoTab({super.key, required this.inCompleteToDos});

  @override
  State<ToDoTab> createState() => _ToDoTabState();
}

class _ToDoTabState extends State<ToDoTab> {
  //handle mark as done
  void _markAsDone(ToDo toDo) async {
    try {
      print(toDo);
      //updated todo
      final ToDo updatedToDo = ToDo(
        id: toDo.id,
        title: toDo.title,
        date: toDo.date,
        time: toDo.time,
        isDone: true,
      );
      await ToDoService().markAsDone(updatedToDo);

      //show snackbar
      AppHelpers.showSnackBar(context, "Marked as Done");
      setState(() {
        widget.inCompleteToDos.remove(toDo);
      });
      AppRouter.router.go("/todos");
    } catch (e) {
      print(e);
      //show snackbar
      AppHelpers.showSnackBar(context, "Failed to mark as Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.inCompleteToDos.sort((a, b) => a.date.compareTo(b.date));
    });
    return ToDoData(
      todos: widget.inCompleteToDos,
      onTodosChanged: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.inCompleteToDos.length,
                itemBuilder: (context, index) {
                  final ToDo toDo = widget.inCompleteToDos[index];
                  return Dismissible(
                    key: Key(toDo.id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        widget.inCompleteToDos.removeAt(index);
                        ToDoService().deleteTodo(toDo);
                      });

                      AppHelpers.showSnackBar(context, "Deleted");
                    },
                    child: TodoCard(
                      toDo: toDo,
                      isComplete: false,
                      onCheckBoxChanged: () => _markAsDone(toDo),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
