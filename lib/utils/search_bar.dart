import 'package:flutter/material.dart';
import '../models/databaseHelper.dart';
import '../models/note.dart';
import 'note_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({Key? key}) : super(key: key);

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  late List<Note> notes;
  late TextEditingController _searchController;
  final DatabaseHelper _databaseService = DatabaseHelper();

  Future<List<Note>> _getNotes() async {
    return await _databaseService.getNotes();
  }
  @override
  void initState() {
    _searchController = TextEditingController();
    notes=[];
    // Initialize notes here. You might need to fetch them from a database or API.
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchableList<Note>(
        seperatorBuilder: (context, index) {
          return const Divider();
        },
        style: const TextStyle(fontSize: 15),
        itemBuilder: (Note user)=>NoteItem(note: user,),
        errorWidget: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Error while fetching notes')
          ],
        ),
        initialList: notes,
        filter: (query) {
          return notes.where((element) => element.name.contains(query)).toList();
        },
        emptyWidget: const EmptyView(),
        onRefresh: () async {},
        onItemSelected: (Note item) {},
        inputDecoration: InputDecoration(
          fillColor: Colors.white,
          hintText: 'Search',
        ),
        closeKeyboardWhenScrolling: true,
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[700],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  note.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  note.number.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('No note is found with this text'),
    );
    
  }
}
