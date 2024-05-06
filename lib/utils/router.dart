import 'package:brainbox/pages/create_note.dart';
import 'package:brainbox/pages/home_page.dart';
import 'package:brainbox/pages/notes.dart';
import 'package:brainbox/pages/todos.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      //Home Page route
      GoRoute(
        name: "home",
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: "notes",
        path: '/notes',
        builder: (context, state) {
          return const NotesPage();
        },
      ),
      GoRoute(
        name: "todos",
        path: '/todos',
        builder: (context, state) {
          return const ToDoPage();
        },
      ),

      GoRoute(
        name: "create-note",
        path: "/create-note",
        builder: (context, state) {
          return const CreateNotePage();
        },
      ),
    ],
  );
}
