import 'note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'flutter_sqflite_database.db');
    print('Database path: $path');

    // Delete the existing database for debugging
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        print('Configuring database with foreign keys');
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Creating notes table');
    await db.execute(
      'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, number INTEGER, recv_req BOOLEAN, used BOOLEAN)',
    );
  }

  Future<void> insertNote(Note note) async {
    final db = await _databaseService.database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (index) => Note.fromMap(maps[index]));
  }

  Future<void> updateNote(Note note) async {
    final db = await _databaseService.database;
    await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> updateNoteUsedStatus(int id, bool used) async {
  final db = await _databaseService.database;
  await db.update(
    'notes',
    {'used': used ? true : false}, // 1 for true, 0 for false assuming used is stored as BOOLEAN
    where: 'id = ?',
    whereArgs: [id],
  );
}

  Future<void> deleteNote(int id) async {
    final db = await _databaseService.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
