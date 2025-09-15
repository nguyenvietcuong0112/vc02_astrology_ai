import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'astrology.db');

    return await openDatabase(
      path,
      version: 2, // <-- Tăng version
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // <-- Thêm onUpgrade
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE horoscopes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        place TEXT NOT NULL,
        result TEXT NOT NULL,
        notes TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  // Hàm xử lý nâng cấp
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE horoscopes ADD COLUMN notes TEXT');
    }
  }

  Future<int> insertHoroscope(Map<String, dynamic> horoscope) async {
    final db = await database;
    return await db.insert('horoscopes', horoscope, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getHoroscopes() async {
    final db = await database;
    return await db.query('horoscopes', orderBy: 'createdAt DESC');
  }

  // Hàm cập nhật ghi chú
  Future<int> updateHoroscopeNotes(int id, String notes) async {
    final db = await database;
    return await db.update(
      'horoscopes',
      {'notes': notes},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
