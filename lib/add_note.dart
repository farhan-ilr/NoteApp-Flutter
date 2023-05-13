import 'package:flutter/material.dart';
import 'package:noteapp/functions/db_functions.dart';
import 'package:noteapp/model/data_model.dart';

enum AddNoteAction { addNote, editeNote }

final titleController = TextEditingController();
final contentController = TextEditingController();

TextStyle textStyle(FontWeight fw, double size) {
  return TextStyle(color: Colors.white, fontSize: size, fontWeight: fw);
}

TextFormField _textFormField(
    TextEditingController textEditingController, int lines, String labels) {
  return TextFormField(
      maxLines: lines == 0 ? null : lines,
      controller: textEditingController,
      style: textStyle(FontWeight.normal, 16),
      decoration: InputDecoration(
          label: Text(labels, style: textStyle(FontWeight.bold, 16)),
          border: InputBorder.none));
}

class AddNote extends StatefulWidget {
  final AddNoteAction type;
  final NoteModel? model;

  const AddNote({Key? key, required this.type, this.model}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  void initState() {
    if (widget.type == AddNoteAction.editeNote) {
      titleController.text = widget.model!.title.toString();
      contentController.text = widget.model!.noteContent.toString();
    } else {
      titleController.clear();
      contentController.clear();
    }
    super.initState();
  }

  Widget get deleteButton => TextButton.icon(
      onPressed: () {
        deleteANote(widget.model!.id!);
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.amber,
      ),
      label: Text("Delete", style: textStyle(FontWeight.normal, 16)));

  Widget get saveButton => TextButton.icon(
      onPressed: () {
        switch (widget.type) {
          case AddNoteAction.addNote:
            NoteModel newNote = NoteModel(
                title: titleController.text.trim(),
                noteContent: contentController.text.trim());
            addNotes(newNote);
            break;
          case AddNoteAction.editeNote:
            NoteModel editedNote = NoteModel(
                id: widget.model!.id,
                title: titleController.text.trim(),
                noteContent: contentController.text.trim());
            updateNotes(editedNote);

            break;
        }
      },
      icon: const Icon(Icons.save, color: Colors.amber),
      label: Text("Save", style: textStyle(FontWeight.normal, 16)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black, actions: [
          widget.type == AddNoteAction.editeNote
              ? deleteButton
              : const Text(""),
          saveButton,
        ]),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textFormField(titleController, 1, "Note Title"),
                      const SizedBox(height: 50),
                      _textFormField(contentController, 0, 'Content'),
                      const SizedBox(height: 25)
                    ]))));
  }
}
