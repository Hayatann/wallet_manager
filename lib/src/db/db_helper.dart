import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './consumes.dart';

// カラム名の設定
const String columnId = '_id';
const String columnTitle = 'title';
const String columnPrice = 'price';
const String columnGenre = 'genre';
const String columnDate = 'date';
const String columnCreatedAt = 'createdAt';

const List<String> columns = [
  columnId,
  columnTitle,
  columnPrice,
  columnGenre,
  columnDate,
  columnCreatedAt
];

class DbHelper {
  // DbHelperのinstanceを作成
  static final DbHelper instance = DbHelper._createInstance();
  static Database? _database;

  DbHelper._createInstance();

  // db open and create instance
  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  // open db
  Future<Database> _initDB() async {
    final dbDirectory = await getApplicationSupportDirectory();
    final dbFilePath = dbDirectory.path;
    final path = join(dbFilePath, 'consumes.db');

    return await openDatabase(path,
        version: 1, onCreate: _onCreate); // onCreate:にはdbが無かったときの処理を書く
  }

  // dbが無かったときの処理
  Future _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE consumes (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnPrice INTEGER NOT NULL,
        $columnGenre TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnCreatedAt TEXT NOT NULL
      )
    ''');
  }

  // 全取得
  Future<List<Consumes>> selectAllConsumes() async {
    final db = await instance.database;
    final consumesData = await db.query('consumes');

    return consumesData.map((json) => Consumes.fromJson(json)).toList();
  }

  // _idで1件取得
  Future<Consumes> consumesData(int id) async {
    final db = await instance.database;
    var consumes = [];
    consumes = await db.query(
      'consumes',
      columns: columns,
      where: '$columnId = ?', // 渡されたidと一致するテーブルを取得
      whereArgs: [id],
    );
    return Consumes.fromJson(consumes.first);
  }

  // insert
  Future insert(Consumes consumes) async {
    final db = await instance.database;
    return await db.insert('consumes', consumes.toJson());
  }

  // update
  Future update(Consumes consumes) async {
    final db = await instance.database;
    return await db.update(
      'consumes',
      consumes.toJson(),
      where: '$columnId = ?', // idが一致するものを更新
      whereArgs: [consumes.id],
    );
  }

  // delete
  Future delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'consumes',
      where: '$columnId = ?', // idが一致するものを削除
      whereArgs: [id],
    );
  }
}
