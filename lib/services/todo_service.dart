import 'package:brainbox/models/todo_model.dart';
import 'package:hive/hive.dart';

class ToDoService {
  //all todos
  List<ToDo> todos = [
    ToDo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  //create the database reference for todos
  final _myBox = Hive.box("todos");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // Method to create the initial todos if the box is empty
  Future<void> createInitialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  // Method to load the todos
  Future<List<ToDo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<ToDo>().toList();
    }
    return [];
  }

  // Method to add a todo
  Future<void> addTodo(ToDo todo) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.add(todo);
      await _myBox.put("todos", allTodos);
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  //mark the todo as done
  Future<void> markAsDone(
    ToDo todo,
  ) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element == todo);
      allTodos[index].isDone = true;
      await _myBox.put("todos", allTodos);
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  //update the todo
  Future<void> updateTodo(
    ToDo todo,
  ) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element == todo);
      allTodos[index] = todo;
      await _myBox.put("todos", allTodos);
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  //delete the todo
  Future<void> deleteTodo(
    ToDo todo,
  ) async {
    try {
      //get all todos from the box
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.remove(todo);
      await _myBox.put("todos", allTodos);
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }
}
