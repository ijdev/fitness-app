import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DB {
  static Future<sql.Database> database(String table) async {
    String dbPath = await sql.getDatabasesPath();
    var db = await sql.openDatabase(
      path.join(dbPath, 'mydb.db'),
      // onCreate: (db, version) async {
      //   return await db.execute(
      //       "CREATE TABLE $table (id TEXT PRIMARY KEY, name TEXT, cal REAL, isChecked INTEGER)");
      // },
      version: 1,
    );
    if (table == 'meals') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, name TEXT, cal INTEGER, isChecked INTEGER)");
    } else if (table == 'workout') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, name TEXT, cal INTEGER, isChecked INTEGER)");
    } else if (table == 'goals') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, mealGoal INTEGER, workoutGoal INTEGER, waterGoal INTEGER, sleepGoal INTEGER)");
    } else if (table == 'sleepFuck') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, hours INTEGER)");
      //db.execute("INSERT INTO $table(hours) VALUES(0)");
    } else if (table == 'water') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, water INTEGER)");
    } else if (table == 'mymeals') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, name TEXT, cal INTEGER)");
    } else if (table == 'myworkout') {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $table (id TEXT PRIMARY KEY, name TEXT, cal INTEGER)");
    }

    return db;
  }

  static Future setAndUpdateGoals(
      String table, int meal, int work, int sleep, int water) async {
    final sql.Database db =
        await DB.database(table).catchError((e) => print(e));

    db.execute(
        'INSERT OR IGNORE INTO $table(id, mealGoal, workoutGoal, sleepGoal, waterGoal) VALUES("id", $meal, $work, $sleep, $water)');
    db.execute(
        'UPDATE $table SET mealGoal = $meal, workoutGoal = $work, sleepGoal = $sleep, waterGoal = $water  WHERE id = "id"');
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sql.Database db = await DB.database((table));
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final sql.Database db =
        await DB.database(table).catchError((e) => print(e));

    return db.query(table).catchError((onError) => null);
  }

  static Future remove(String table, String id) async {
    final sql.Database db =
        await DB.database(table).catchError((e) => print(e));

    return db.rawDelete('DELETE FROM $table WHERE id = ?', ['$id']);
  }

  static Future update(
      String table, String id, String name, String cal, int isChecked) async {
    final sql.Database db =
        await DB.database(table).catchError((e) => print(e));

    return db.rawUpdate(
        'UPDATE $table SET name = ?, cal = ?, isChecked = ? WHERE id = ?',
        ['$name', '$cal', '$isChecked', '$id']);
  }

  static Future updateMy(
      String table, String id, String name, String cal) async {
    final sql.Database db =
        await DB.database(table).catchError((e) => print(e));

    return db.rawUpdate('UPDATE $table SET name = ?, cal = ? WHERE id = ?',
        ['$name', '$cal', '$id']);
  }

  static Future<void> insertUpdateSleep(String table, int hours) async {
    final sql.Database db = await DB.database((table));
    db.execute('INSERT OR IGNORE INTO $table(id, hours) VALUES("id", $hours)');
    db.execute('UPDATE $table SET hours = $hours WHERE id = "id"');
  }

  static Future<void> insertUpdateWater(String table, int water) async {
    final sql.Database db = await DB.database((table));
    db.execute('INSERT OR IGNORE INTO $table(id, water) VALUES("id", $water)');
    db.execute('UPDATE $table SET water = $water WHERE id = "id"');
  }
}
