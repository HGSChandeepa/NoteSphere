import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime date;

  Note({
    String? id,
    required this.title,
    required this.category,
    required this.content,
    required this.date,
  }) : id = id ?? const Uuid().v4(); // Generate UUID only if id is not provided
}
