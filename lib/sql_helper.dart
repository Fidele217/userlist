import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        firstName TEXT,
        lastName TEXT,
        dob TEXT,
        phone TEXT,
        mail TEXT,
        address TEXT,
        gender TEXT,
        photo TEXT,
        citation TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'userdata.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String firstName,
      String? lastName,
      String phone,
      String mail,
      String address,
      String gender,
      String photo,
      String citation) async {
    final db = await SQLHelper.db();

    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'mail': mail,
      'address': address,
      'gender': gender,
      'photo': photo,
      'citation': citation
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id,
      String firstName,
      String? lastName,
      String phone,
      String mail,
      String address,
      String gender,
      String photo,
      String citation) async {
    final db = await SQLHelper.db();

    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'mail': mail,
      'address': address,
      'gender': gender,
      'photo': photo,
      'citation': citation,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
