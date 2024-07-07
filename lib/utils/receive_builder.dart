import 'package:flutter/material.dart';
import '../models/note.dart';
import 'note_widget.dart';
import '../models/databaseHelper.dart';
class ReceiveBuilder extends StatelessWidget {
  final Future<List<Note>> future;
  final Function(Note) onDelete;

  ReceiveBuilder({required this.future, required this.onDelete});

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
          final filteredNotes = snapshot.data!.where((note) => note.recv_req).toList();
          return ListView.builder(
            
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              final note = filteredNotes[index];
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
