import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/add_note.dart';
import 'package:noteapp/functions/db_functions.dart';
import 'package:noteapp/note_widget.dart';

import 'model/data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)) {
    Hive.registerAdapter(NoteModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // color: Colors.black,
        title: 'Note App',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.dmSans().fontFamily),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    getAllNote();
    return Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(children: [
                const Icon(Icons.hourglass_empty),
                const SizedBox(width: 15),
                Text("Notes", style: textStyle(FontWeight.w600, 25))
              ])),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: notesNotifier,
          builder: (BuildContext ctx, List<NoteModel> notes, Widget? _) {
            return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(20),
                children: List.generate(notes.length, (index) {
                  return Note(
                    model: notes[index],
                  );
                }));
          },
        )),
        backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return AddNote(type: AddNoteAction.addNote);
            }));
          },
          tooltip: 'Increment',
          label: Text("New", style: textStyle(FontWeight.bold, 17)),
          icon: const Icon(Icons.add),
        ));
  }
}
