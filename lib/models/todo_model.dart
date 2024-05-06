import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 2)
class ToDo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final DateTime time;

  @HiveField(4)
  final bool isDone;

  ToDo({
    String? id,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  }) : id = id ?? const Uuid().v4();
}
