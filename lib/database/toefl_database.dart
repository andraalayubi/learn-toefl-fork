import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:learn_toefl/database/insert_data.dart';

class ToeflDatabase {
  static final ToeflDatabase instance = ToeflDatabase._init();
  ToeflDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('toefl.db');
    
    // Memanggil fungsi insertVideos setelah database dibuat
    insertVideos();
    insertPractices();
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE User (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username VARCHAR(255)
        )
        ''');

    await db.execute('''
        CREATE TABLE VideoCategory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(255),
          subCategory_id INT,
          FOREIGN KEY (subCategory_id) REFERENCES SubCategory(id)
        )
        ''');

    await db.execute('''
        CREATE TABLE SubCategory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(255)
        )
        ''');

    await db.execute('''
        CREATE TABLE Video_User (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INT,
          video_id INT,
          position INT,
          duration INT,
          FOREIGN KEY (user_id) REFERENCES User(id),
          FOREIGN KEY (video_id) REFERENCES Video(id)
        )
        ''');

    await db.execute('''
        CREATE TABLE Video (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(255),
          url VARCHAR(255),
          video_category_id INT,
          FOREIGN KEY (video_category_id) REFERENCES VideoCategory(id)
        )
        ''');

    await db.execute('''
        CREATE TABLE Question_Category (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          reading_text TEXT,
          user_id INT,
          nilai INT,
          FOREIGN KEY (user_id) REFERENCES User(id)
        )
        ''');

    await db.execute('''
        CREATE TABLE Question (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          question_text TEXT,
          correct_answer_id INT,
          question_category_id INT,
          FOREIGN KEY (correct_answer_id) REFERENCES Answer(id),
          FOREIGN KEY (question_category_id) REFERENCES Question_Category(id)
        )
        ''');

    await db.execute('''
        CREATE TABLE Answer (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          answer_text TEXT,
          question_id INT,
          FOREIGN KEY (question_id) REFERENCES Question(id)
        )
        ''');
  }
}
