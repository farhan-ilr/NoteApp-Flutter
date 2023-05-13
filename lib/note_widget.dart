import 'package:flutter/material.dart';
import 'package:noteapp/add_note.dart';
import 'dart:math' as math;

import 'package:noteapp/model/data_model.dart';

class Note extends StatelessWidget {
  final NoteModel model;
  const Note({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return AddNote(
              type: AddNoteAction.editeNote,
              model: model,
            );
          }));
        },
        child: Container(
            decoration: BoxDecoration(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              Text(model.title.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(FontWeight.bold, 20)),
              const SizedBox(height: 5),
              Text(model.noteContent,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle(FontWeight.normal, 17)),
              Text(model.id.toString())
            ])));
  }
}
