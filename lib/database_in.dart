import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_database/produk_model.dart';
import 'package:sqflite/sqflite.dart';

// 1. Gunakan 'class' (huruf kecil semua)
class DatabaseIn {
  final String table = 'contacts';
  Database? _db;

  Future<Database>  database () async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // 2. Gunakan $table untuk memanggil variabel 'table'
        await db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            phone TEXT,
            email TEXT
          )
        ''');
      },
    );
  }
  Future<int> insert(ContactModel data) async {
    final db = await database();
    return await db.insert(table, data.toMap());
  }

  Future<List<ContactModel>> getAll() async {
    final db = await database();
    final result = await db.query(table);

    return result.map((e) => ContactModel.fromMap(e)).toList();
  }

  Future<int> update(ContactModel data) async {
    final db = await database();

    return await db.update(table,
    data.toMap(),
    where: 'id = ?',
    whereArgs: [data.id],
    );  

    
  }

  Future<void> delete(int id) async {}
}