import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/databaseHelper.dart'; // Import your database helper

class NoteWidget extends StatefulWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteWidget({
    required this.note,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  final DatabaseHelper _databaseService = DatabaseHelper();

  void _showChangeUsedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change to Used?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                await _databaseService.updateNoteUsedStatus(widget.note.id!, true);
                setState(() {
                  widget.note.used = true;
                });
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: widget.note.used ? Colors.yellow[100] : Colors.purpleAccent[50], // Change color based on used status
      child: ListTile(
        leading: Icon(widget.note.used ? Icons.check :(widget.note.recv_req ? Icons.download : Icons.upload)),
        title: Text(widget.note.name),
        subtitle: Text('Quantity: ${widget.note.number}'),
        onLongPress: _showChangeUsedDialog, // Show dialog on long press
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: widget.onDelete,
        ),
      ),
    );
  }
}
