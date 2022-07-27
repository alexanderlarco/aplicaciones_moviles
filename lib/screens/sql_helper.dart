import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:async';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE pedidos(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        prenda TEXT,
        descripcion TEXT,
        codigo TEXT,
        cliente TEXT,
        fecha TEXT, 
        createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updatedAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'kindacode.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String? prenda, String? descripcion, String? codigo, String? cliente, String? fecha) async {
    final db = await SQLHelper.db();

    final data = {'prenda':prenda, 'descripcion': descripcion, 'codigo':codigo, 'cliente':cliente, 'fecha':fecha};
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

  // Update an item by id, 
  static Future<int> updateItem(
      int id, String prenda, String? descripcion, String? codigo, String? cliente, String? fecha) async {
    final db = await SQLHelper.db();

    final data = {
      'prenda': prenda,
      'descripcion': descripcion,
      'codigo': codigo,
      'cliente': cliente,
      'fecha': fecha,
      'createdAt': DateTime.now().toString(),
      'updateddAt': DateTime.now().toString()
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

