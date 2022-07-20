import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

late Database _db;

//creating or open databse
Future<void> openDB() async {
  _db = await openDatabase('buttonValue.db', version: 1,
      onCreate: (Database db, int version) async {
    await db
        .execute('CREATE TABLE buttonValue (id INTEGER PRIMARY KEY,name TEXT)');
  },);
}
//get all details from local db

Future<void> getAllData() async {
  final _values = await _db.rawQuery('SELECT * FROM buttonValue');

  print(_values);
  // Text(_values);
}

//delete all datas from table
Future<void> deleteData() async{
  await _db.rawDelete('DELETE  FROM buttonValue');
  print('all data deleted!');
}

//insert datas to local db

Future<void> insertData(emoji) async {
 late  String value = emoji.toString();
  if(value == 'Very_Good'){
    _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("Very_Good")');
    print('feeling very good accepted!');
   
  }
  else if(value == 'Good')
  {
  _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("Good")');
  print('feeling good accepted!');
  
  }
  else if(value == 'Nothing')
  {
    _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("Good")');
    print('feeling nothing accepted');
  }
  else if(value == 'Bad'){
    _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("Bad")');
  }
  else{
    _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("Very_Bad")');
    print('feeling very bad accepted');
  }
  
 // _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("palakkal")');
  getAllData();
}
