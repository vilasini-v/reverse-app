import 'package:construction_part2/utils/inventory_builder.dart';
import 'package:flutter/material.dart';
import '../utils/material_name.dart';
import '../models/databaseHelper.dart';
import '../models/note.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key, this.note}) : super(key: key);
  final Note? note;
  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
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

  late TextEditingController _textController;
  late TextEditingController _amountController;

  String text = "";
  int amount = 0;

  void _clearTextFields() {
    _textController.clear();
    _amountController.clear();
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _amountController = TextEditingController();

    if (widget.note != null) {
      _textController.text = widget.note!.name;
      _amountController.text = widget.note!.number.toString();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
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
              return NoteBuilder(
                future: _getNotes(),
                onDelete: _onNoteDelete,
              );
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 35),
          FloatingActionButton.extended(
            extendedPadding: EdgeInsets.symmetric(horizontal: 20),
            icon: Icon(Icons.add),
            label: Text('Receive'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Receive',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          DropdownMenu<MaterialName>(
                            controller: _textController,
                            enableFilter: true,
                            requestFocusOnTap: true,
                            leadingIcon: const Icon(Icons.search),
                            label: const Text('Enter Material Name'),
                            width: 300,
                            inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            ),
                            dropdownMenuEntries: MaterialName.values.map<DropdownMenuEntry<MaterialName>>(
                              (MaterialName icon) {
                                return DropdownMenuEntry<MaterialName>(
                                  value: icon,
                                  label: icon.label,
                                );
                              },
                            ).toList(),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: "Enter quantity"),
                            controller: _amountController,
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            child: Text("Save"),
                            onPressed: () async {
                              await (widget.note == null
                                  ? _databaseService.insertNote(
                                      Note(
                                        name: _textController.text,
                                        number: int.parse(_amountController.text),
                                        recv_req: true,
                                        used: false,
                                      ),
                                    )
                                  : _databaseService.updateNote(
                                      Note(
                                        id: widget.note!.id,
                                        name: _textController.text,
                                        number: int.parse(_amountController.text),
                                        recv_req: true,
                                        used: false,
                                      ),
                                    ));
                              Navigator.pop(context);
                              _clearTextFields();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(width: 50),
          FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text('Request'),
            extendedPadding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            'Request',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          DropdownMenu<MaterialName>(
                            controller: _textController,
                            enableFilter: true,
                            requestFocusOnTap: true,
                            leadingIcon: const Icon(Icons.search),
                            label: const Text('Enter Material Name'),
                            width: 300,
                            inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            ),
                            dropdownMenuEntries: MaterialName.values.map<DropdownMenuEntry<MaterialName>>(
                              (MaterialName icon) {
                                return DropdownMenuEntry<MaterialName>(
                                  value: icon,
                                  label: icon.label,
                                );
                              },
                            ).toList(),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: "Enter quantity"),
                            controller: _amountController,
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            child: Text("Save"),
                            onPressed: () async {
                              await (widget.note == null
                                  ? _databaseService.insertNote(
                                      Note(
                                        name: _textController.text,
                                        number: int.parse(_amountController.text),
                                        recv_req: false,
                                        used: false,
                                      ),
                                    )
                                  : _databaseService.updateNote(
                                      Note(
                                        id: widget.note!.id,
                                        name: _textController.text,
                                        number: int.parse(_amountController.text),
                                        recv_req: false,
                                        used: false,
                                      ),
                                    ));
                              Navigator.pop(context);
                              _clearTextFields();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
