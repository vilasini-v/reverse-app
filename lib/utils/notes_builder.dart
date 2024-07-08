import 'package:flutter/material.dart';
import '../models/note.dart';
import 'note_widget.dart';
class NotesBuilder extends StatelessWidget {
  final Future<List<Note>> future;
  final Function(Note) onDelete;
  late String page;
  NotesBuilder({required this.future, required this.onDelete, required this.page});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No notes found'));
        } else {
          List<Note> filteredNotes = snapshot.data!;
          if(page=='used'){
            filteredNotes = snapshot.data!.where((note) => note.used).toList();
          }else if (page == ' receive') {
            filteredNotes = snapshot.data!.where((note) => note.recv_req).toList();
          } else if (page == 'request'){
            filteredNotes = snapshot.data!.where((note) => !note.recv_req).toList();
          } else if (page == 'all'){
            filteredNotes = snapshot.data!;
          }
          return ListView.builder(
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              final note = filteredNotes[index];
              return NoteWidget(
                note: note,
                onDelete: () => onDelete(note),
              );
            },
          );
        }
      },
    );
  }
}
