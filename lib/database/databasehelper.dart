import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'profile.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE profiles(id INTEGER PRIMARY KEY, imagePath TEXT)',
        );
      },
    );
  }

  Future<void> insertProfileImage(String imagePath) async {
    final db = await database;
    await db.insert('profiles', {'imagePath': imagePath},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getProfileImage() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('profiles');
    return maps.isNotEmpty ? maps.first['imagePath'] as String : null;
  }
}
