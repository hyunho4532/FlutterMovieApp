import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future _openDb() async {
  final databasePath = await getDatabasesPath();

  String path = join(databasePath, 'favorite.db');

  final db = await openDatabase (
    path,
    version: 1,
    onConfigure: (db) => {},
    onCreate: (db, version) => {},
    onUpgrade: (db, oldVersion, newVersion) => {},
  );
}

Future _onCreate(Database db, int version) async {
  await db.execute (
    '''
    CREATE TABLE IF NOT EXISTS actors (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      created_at TEXT NOT NULL
    )
    '''
  );
}

Future add(item) async {
  final db = await _openDb();

  item.id = await db.insert (
    'actors',
    {
      'title': 'new posts ....',
      'content': 'this is add method',
      'create_at': '2022-01-01 00:00:00',
    },

    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return item;
}