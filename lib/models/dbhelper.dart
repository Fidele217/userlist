import 'package:sqflite/sqflite.dart';
import 'package:tp_flutter_ifri_2022/models/individu.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final _databaseName = "individu_db.db";
  static final _databaseVersion = 1;

  static final table = 'individus_table';

  static const tblIndividu='indidus';
  static const colId='id';
  static const colFirstname='firstname';
  static const colLastname='lastname';
  static const colDateOfBirth='dateOfBirth';
  static const colPhone='phone';
  static const colMail='mail';
  static const colGender='gender';
  static const colCitation='citation';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

 late  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
// lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    _database = await _initDatabase();
    return _database;
  }


  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $table ($colId INTEGER PRIMARY KEY AUTOINCREMENT,
$colFirstname TEXT NOT NULL,
$colLastname INTEGER NOT NULL,
$colDateOfBirth DATE NOT NULL,
$colGender TEXT NOT NULL,
$colPhone TEXT NOT NULL,
$colMail TEXT NOT NULL,
$colCitation TEXT NOT NULL,
)
''');
  }


  Future<int> insert(Individu individu) async {
    Database db = await instance.database;
    return await db.insert(table, {'firstname': individu.firstname, 'miles': individu.lastname});
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$colFirstname LIKE '%$name%'");
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Individu individu) async {
    Database db = await instance.database;
    int id = individu.toMap()['id'];
    return await db.update(
        table, individu.toMap(), where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$colId = ?', whereArgs: [id]);
  }
}