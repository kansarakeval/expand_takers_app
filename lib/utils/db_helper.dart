import 'dart:io';
import 'package:expand_takers_app/screen/model/db_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper helper = DbHelper._();
  DbHelper._();

  Database? database;
  final String DB_NAME = "data.db";

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String queryIncomeTable =
            "CREATE TABLE incomeExpense (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount TEXT,category TEXT,notes TEXT,time TEXT,date TEXT,status INTEGER)";
        String queryCategoryTable =
            "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT) ";
        db.execute(queryIncomeTable);
        db.execute(queryCategoryTable);
      },
    );
  }

  Future<void> insertData(DBModel model) async {
    database = await checkDB();
    database!.insert("incomeExpense", {
      "title": model.title,
      "amount": model.amount,
      "category": model.category,
      "notes": model.notes,
      "time": model.time,
      "date": model.date,
      "status": model.status
    });
  }

  void readData() {}

  void updateData() {}

  void deleteData() {}
}
