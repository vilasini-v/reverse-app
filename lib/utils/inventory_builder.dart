import 'package:flutter/material.dart';
import '../models/note.dart';
import 'note_widget.dart';
class NoteBuilder extends StatelessWidget {
  final Future<List<Note>> future;
  final Function(Note) onDelete;

  NoteBuilder({required this.future, required this.onDelete});

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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final note = snapshot.data![index];
              print('Building note: ${note.name}'); // Debug print
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
