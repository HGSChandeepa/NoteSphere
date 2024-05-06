import 'package:brainbox/utils/router.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:brainbox/widgets/notes_todo_card.dart';
import 'package:brainbox/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const ProgressCard(
              completedTasks: 2,
              totalTasks: 5,
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
                  child: const NotesTodoCard(
                    title: 'Notes',
                    description: '40 pages',
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                GestureDetector(
                  //go to todo page using gorouter
                  onTap: () {
                    AppRouter.router.push("/todos");
                  },
                  child: const NotesTodoCard(
                    title: 'To-Do List',
                    description: '5 tasks',
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
          ],
        ),
      ),
    );
  }
}
