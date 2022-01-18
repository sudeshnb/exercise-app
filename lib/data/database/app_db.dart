import 'package:exercise_app/data/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/alarm.dart';

class ExerciseDatabase {
  static final ExerciseDatabase instance = ExerciseDatabase._();
  late Database database;
  ExerciseDatabase._() {
    init();
  }
  init() async {
    database = await _initDB('exercise.db');
    return database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute(
        'CREATE TABLE arlam (_id $idType, isOn $boolType, remindTime $textType, weekID $textType)');
    await db.execute(
        'CREATE TABLE week (_id $idType, week $textType, weekID $textType)');
    await db.execute(
        'CREATE TABLE user (_id INTEGER PRIMARY KEY, name $textType, gender $textType, weight $textType, height $textType, bmi $textType, birth $textType)');
  }

  Future<void> insertArlam(Alarm remind) async {
    final db = database;
    await db.insert('arlam', remind.toMap());
  }

  Future<void> insertRepeat(RepateArlam arlam) async {
    final db = database;
    await db.insert('week', arlam.toMap());
  }

  // Future<void> insertUser() async {
  //   final db = database;
  //   const user = User(
  //     id: 0,
  //     name: '',
  //     height: '',
  //     weight: '',
  //     gender: '',
  //     bmi: '',
  //   );
  //   await db.insert('user', user.toMap());
  // }

  Future<List<RepateArlam>> readArlam(String id) async {
    final db = database;

    final result = await db.query(
      'week',
      columns: ['_id', 'week', 'weekID'],
      where: 'weekID = ?',
      whereArgs: [id],
    );
    return result.map((json) => RepateArlam.fromJson(json)).toList();
  }

  Future<User> user() async {
    final db = database;

    final maps = await db.query(
      'user',
      columns: ['_id', 'name', 'gender', 'weight', 'height', 'bmi', 'birth'],
      where: '_id = 1',
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      const user = User(
          id: 1,
          name: '',
          height: '',
          weight: '',
          gender: '',
          bmi: '0.0',
          birth: '');
      await db.insert('user', user.toMap());
      return user;
      // throw Exception('ID 0 not found');
    }
  }

  Future<void> updateUser(String column, String value) async {
    final db = database;
    await db.update(
      'user',
      {column: value},
      // user.toMap(),
      where: '_id = 1',
    );
  }

  Future<List<Alarm>> showAll() async {
    final db = database;
    const orderBy = 'remindTime ASC';
    final result = await db.query('arlam', orderBy: orderBy);
    return result.map((json) => Alarm.fromJson(json)).toList();
  }

  Future<void> update(Alarm arlam) async {
    final db = database;
    await db.update(
      'arlam',
      arlam.toMap(),
      where: '_id = ?',
      whereArgs: [arlam.id],
    );
  }

  Future<int> delete(int id) async {
    final db = database;
    return await db.delete(
      'arlam',
      where: '_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = database;
    return await db.delete('user');
  }

  Future close() async {
    final db = database;
    db.close();
  }
}
