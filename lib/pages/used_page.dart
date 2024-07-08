import 'package:construction_part2/models/note.dart';
import 'package:construction_part2/utils/notes_builder.dart';
import 'package:flutter/material.dart';
import '../models/databaseHelper.dart';


class UsedPage extends StatefulWidget {
  const UsedPage({Key? key, this.note}) : super(key: key);
  final Note? note;
  @override
  State<UsedPage> createState() => _UsedPageState();
}

class _UsedPageState extends State<UsedPage> {
  
  final DatabaseHelper _databaseService = DatabaseHelper();

  Future<List<Note>> _getNotes() async {
    final notes = await _databaseService.getNotes();
    print('Fetched notes: $notes'); // Debug print
    return notes;
  }

  Future<void> _onNoteDelete(Note note) async {
    await _databaseService.deleteNote(note.id!);
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Note>>(
          future: _getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No notes found'));
            } else {
              return NotesBuilder(
                future: _getNotes(),
                onDelete: _onNoteDelete,
                page: 'used',
              );
            }
          },
        ),
      ), 
          
          
    );
  }
}