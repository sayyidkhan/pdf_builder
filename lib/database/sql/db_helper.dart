import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_builder/database/dao/pdfDAO.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String FILENAME = 'fileName';
  static const String FILEPATH = 'filePath';
  static const String TABLE = 'pdfList';
  static const String DB_NAME = 'listOfPdf.db';

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db,int version) async {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $FILENAME TEXT, $FILEPATH TEXT)");
  }

  Future<PdfDB> save(PdfDB pdfDB) async {
    var dbClient = await db;
    pdfDB.id = await dbClient.insert(TABLE, pdfDB.toMap());
    return pdfDB;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($FILENAME) VALUES ('"+pdfDB.fileName + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<PdfDB>> getPdfDB({dbClient}) async {
    if(dbClient == null){
      dbClient = await db;
    }

    List<Map> maps = await dbClient.query(TABLE, columns: [ID,FILENAME,FILEPATH]);
    // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<PdfDB> pdfDBList = [];
    print("items in list: " + maps.length.toString());
    if(maps.length > 0){
      for(int i = 0;i < maps.length;i++){
          pdfDBList.add(PdfDB.fromMap(maps[i]));
      }
    }
    return pdfDBList;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: "$ID = ?", whereArgs: [id]);
  }

  Future<int> update(PdfDB pdfDB) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, pdfDB.toMap(),where: "$ID = ?",whereArgs: [pdfDB.id]);
  }

  Future close() async {
    var dbClient = await db;
    _db = null;
    dbClient.close();
  }

}