import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/model/data_model.dart';

ValueNotifier<List<NoteModel>> notesNotifier = ValueNotifier([]);

addNotes(NoteModel note) async {
  final noteDB = await Hive.openBox<NoteModel>('noteApp db');
  noteDB.put(note.id, note);
  await getAllNote();
}

getAllNote() async {
  final noteDB = await Hive.openBox<NoteModel>('noteApp db');
  notesNotifier.value.clear();
  notesNotifier.value.addAll(noteDB.values);
  notesNotifier.notifyListeners();
}

deleteANote(String id) async {
  final noteDB = await Hive.openBox<NoteModel>('noteApp db');
  await noteDB.delete(id);
  await getAllNote();
}

updateNotes(NoteModel note) async {
  final noteDB = await Hive.openBox<NoteModel>('noteApp db');
  noteDB.delete(note.id);
  noteDB.put(note.id, note);
  await getAllNote();
}
