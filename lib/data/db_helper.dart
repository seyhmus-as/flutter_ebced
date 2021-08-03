import 'dart:async';
import 'package:ebced/models/ebced.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  Database? _db;

  Future<Database?> get db async {
    if(_db==null){
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database?> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"etrade.db");
    var eTradeDb = openDatabase(dbPath,version: 1,onCreate: createDb);
    return await eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute("create table ebceds(id integer primary key,name text,head text,calculatedTime text)");
  }
  Future<List<Ebced>> getEbceds() async{
    Database? db = await this.db;
    var result = await db!.query("ebceds");
    return List.generate(result.length, (i){
      return Ebced.fromObject(result[i]);
    });
  }

  Future<int> insert(Ebced ebced) async {
    Database? db = await this.db;
    var result = await db!.insert("ebceds", ebced.toMap()!);
    return result;
  }

  Future<int> delete(int id) async {
    Database? db = await this.db;
    var result = await db!.rawDelete("delete from ebceds where id=$id");
    return result;
  }

  Future<int> update(Ebced ebced) async {
    Database? db = await this.db;

    var result = await db!.update("ebceds", ebced.toMap()!,
        where: "id=?", whereArgs: [ebced.id]);
    return result;
  }
}