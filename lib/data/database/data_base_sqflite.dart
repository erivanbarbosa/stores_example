import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSqflite {
  final StringBuffer sqlCreate = StringBuffer();
  static final DatabaseSqflite _instance = DatabaseSqflite.internal();
  factory DatabaseSqflite.instance() => _instance;
  DatabaseSqflite();

  static Database? _db;
  DatabaseSqflite.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  String createScriptPushNotification() {
    sqlCreate.clear();
    sqlCreate.writeln('CREATE TABLE pushnotification(');
    sqlCreate.writeln(' id INTEGER PRIMARY KEY autoincrement,');
    sqlCreate.writeln(' body TEXT,');
    sqlCreate.writeln(' title TEXT,');
    sqlCreate.writeln(' read TEXT,');
    sqlCreate.writeln(' created_at INTEGER)');
    return sqlCreate.toString();
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'arkeydb.db');
    return await openDatabase(path, version: 2, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute('DROP TABLE pushnotification');
      await db.execute(createScriptPushNotification());
    }, onDowngrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute('DROP TABLE pushnotification');
      await db.execute(createScriptPushNotification());
    }, onCreate: (Database db, int newerVersion) async {
      await db.execute(createScriptPushNotification());
    });
  }

  Future<List> getTable_(String table) async {
    Database dbClient = await db;
    List result = await dbClient.query(table);

    return result.toList();
  }

  Future<List<Map<String, dynamic>>> getRawTable_(String table) async {
    Database dbClient = await db;
    List<Map<String, Object?>> records = await dbClient.query(table);
    records.forEach((element) {
      var title = element['title'];
      print(element);
    });
    return records;
  }

  Future<List> query_(String table, {required String where, required bool distinct, required String orderBy, required List<dynamic> whereArgs}) async {
    Database dbClient = await db;
    List result = await dbClient.query(table, where: where, orderBy: orderBy, whereArgs: whereArgs);

    return result.toList();
  }

  void executeSQL(String script) async {
    Database dbClient = await db;
    try {
      await dbClient.execute(script);
    } catch (e) {}
  }

  Future<List> getById_(String table, String fieldId, int id) async {
    Database dbClient = await db;
    return await dbClient.query(table, where: '$fieldId = ?', whereArgs: [id]);
  }

  Future<List> getByIdStr_(String table, String fieldId, String id) async {
    Database dbClient = await db;
    return await dbClient.query(table, where: '$fieldId = ?', whereArgs: [id]);
  }

  Future<int> getCount_(String table) async {
    Database dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $table'))!;
  }

  Future<int> countUnreads(String table) async {
    Database dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $table WHERE read = ?', ['UNREAD']))!;
  }

  Future<int> getNextId_(String table, String fieldId) async {
    Database dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT MAX(COALESCE($fieldId, 0)) + 1 FROM $table'))!;
  }

  Future<int> insert_(String table, Map<String, dynamic> options) async {
    Database dbClient = await db;
    return await dbClient.insert(table, options);
  }

  Future<int> update_(String table, String where, Map<String, dynamic> options, int id) async {
    Database dbClient = await db;
    return await dbClient.update(table, options, where: where, whereArgs: [id]);
  }

  Future<int> updateAsRead() async {
    Database dbClient = await db;
    return await dbClient.rawUpdate('UPDATE pushnotification SET read = ? WHERE read = ?', ['READ', 'UNREAD']);
  }

  Future<int> updateStr_(String table, String where, Map<String, dynamic> options, String key) async {
    Database dbClient = await db;
    return await dbClient.update(table, options, where: where, whereArgs: [key]);
  }

  Future<int> delete_(String table, String where, int id) async {
    Database dbClient = await db;
    return await dbClient.delete(table, where: where, whereArgs: [id]);
  }

  Future<int> deleteAll_(String table) async {
    Database dbClient = await db;
    return await dbClient.delete(table);
  }

  Future<int> deleteByParams_(String table, String where, String param) async {
    Database dbClient = await db;
    return await dbClient.delete(table, where: where, whereArgs: [param]);
  }

  Future<dynamic> close() async {
    Database dbClient = await db;
    return dbClient.close();
  }
}
