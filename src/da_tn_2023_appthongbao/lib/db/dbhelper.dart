import 'package:da_tn_2023_appthongbao/model/task.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{
  static Database? _db;
  static final int _version=1;
  static final String _tablename ="task";
  static Future<void>initDb()async{
    if(_db!=null){
      return;
    }
    try{
      String _path= await getDatabasesPath()+ 'task.db';
      _db=await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creating");
          return db.execute(
            "create Table $_tablename("
            "id Integer Primary key AutoIncrement, "
            "title String,note Text,date String, "
            "startTime String,endTime String,"
            "remind Integer, repeat String,color Integer, "
            " isCompleted Integer)",
            );
        },
        );
    }catch(e){
      print(e);
    }
  }
  static Future<int>insert( Task? tack )async{
    print("insert fuction called");
    return await _db?.insert(_tablename, tack!.toJson())??1;
  }
  static Future<List<Map<String,dynamic>>>query()async{
    print("query fuction called");
    
    return await _db!.query(_tablename);
  }
  static delete(Task task)async{
   await _db!.delete(_tablename,where: "id=?",whereArgs: [task.id]);
  }
  static update(int id)async{
    return await _db!.rawUpdate('''
    UPDATE $_tablename
    SET isCompleted =?
    WHERE id=?
    ''',[1,id]);
  }
}