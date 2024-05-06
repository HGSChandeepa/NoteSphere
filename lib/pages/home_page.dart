import 'package:brainbox/utils/text_styles.dart';
import 'package:brainbox/widgets/progress_card.dart';
import 'package:flutter/material.dart';

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
        body: Column(
          children: [
            const SizedBox(height: 20),
            ProgressCard(
              completedTasks: 2,
              totalTasks: 5,
            ),
          ],
        ));
  }
}
