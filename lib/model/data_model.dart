import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String noteContent;

  NoteModel({required this.title, required this.noteContent, this.id}) {
    id = const Uuid().v1();
  }
}
