class QuizQuestion {
  String mainSubject;
  String question;
  List<String> options;
  int correctAnswerIndex;

  QuizQuestion({
    required this.mainSubject,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}
