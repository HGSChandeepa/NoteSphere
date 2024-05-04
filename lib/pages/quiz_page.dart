import 'package:brainbox/data/quiz_data.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  List<int?> userAnswers = List.filled(mathQuizQuestions.length, null);

  void selectAnswer(int selectedIndex) {
    setState(() {
      userAnswers[currentIndex] = selectedIndex;
      print(userAnswers);
    });
  }

  void goToNextQuestion() {
    setState(() {
      if (currentIndex < mathQuizQuestions.length - 1) {
        currentIndex++;
      }
    });
  }

  void goToPreviousQuestion() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              mathQuizQuestions[currentIndex].question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: mathQuizQuestions[currentIndex]
                  .options
                  .asMap()
                  .entries
                  .map((option) => ElevatedButton(
                        onPressed: () {
                          selectAnswer(option.key);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: userAnswers[currentIndex] ==
                                  option.key
                              ? Colors.green // Change color for selected answer
                              : null,
                        ),
                        child: Text(option.value),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: goToPreviousQuestion,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: goToNextQuestion,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
