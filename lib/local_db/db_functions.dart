import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_4/screen_home.dart';


class sample{

 
}

late Database _db;

//creating or open databse
Future<void> openDB() async {

  _db = await openDatabase('buttonValue.db', version: 1,
      onCreate: (Database db, int version) async {
    await db
        .execute('CREATE TABLE buttonValue (id INTEGER PRIMARY KEY,name TEXT,date TEXT)');
  },);
}

//alter the table --add column date
Future<void> altertabel() async{
 // var _db = await openDatabase;
  await _db.execute("ALTER TABLE buttonValue ADD " "COLUMN date TEXT;");
  print(await _db.query('buttonValue'));
 // return count;
}
//get all details from local db

Future<void> getAllData([lst]) async {
  final _values = await _db.rawQuery('SELECT * FROM buttonValue');
 // SELECT last_insert_rowid();
 
//final lastid = await _db.rawQuery('SELECT last_insert_rowid();');
 //print(lastid.runtimeType);
 

  print(_values); //used to display the whole datas in the loal database.
 // print(lastid);
  var lastdate = await _db.rawQuery ('SELECT date FROM buttonValue ORDER BY date DESC LIMIT 1 ')as List; 
  var lst = int.parse(lastdate[0] ['date']);
  //print(lastdate[0] ['date']); 
  print(lst);
 // datecheking(lsti);
  
  var dt = DateTime.now();
 // print(dt.day);
  if(lst == dt.day){
    print("dates are equal");
  }
  // Text(_values);
  
}

//getting last inserted date
Future<void> lastdate()async{
  final _lastid = await _db.rawQuery('SELECT last_insert_rowid();');
  final _lastdate = await _db.rawQuery('SELECT COLUMN date FROM buttonValue WHERE(id =_lastid)');
  print(_lastdate);
}

//delete all datas from table
Future<void> deleteData() async{
  await _db.rawDelete('DELETE  FROM buttonValue');
  print('all data deleted!');
}

//insert datas to local db

Future<void> insertData(emoji, dayNo) async {
 late  String value = emoji.toString();
  if(value == 'Very_Good'){
    _db.rawInsert('INSERT INTO buttonValue(name,date) VALUES ("Very_Good",$dayNo)');
    print('feeling very good accepted!');
   
  }
  else if(value == 'Good')
  {
  _db.rawInsert('INSERT INTO buttonValue(name,date) VALUES ("Good",$dayNo)');
  print('feeling good accepted!');
  
  }
  else if(value == 'Nothing')
  {
    _db.rawInsert('INSERT INTO buttonValue(name,date) VALUES ("Good",$dayNo)');
    print('feeling nothing accepted');
  }
  else if(value == 'Bad'){
    _db.rawInsert('INSERT INTO buttonValue(name,date) VALUES ("Bad",$dayNo)');
  }
  else{
    _db.rawInsert('INSERT INTO buttonValue(name,date) VALUES ("Very_Bad",$dayNo)');
    print('feeling very bad accepted');
  }
  
 // _db.rawInsert('INSERT INTO buttonValue(name) VALUES ("palakkal")');
  getAllData();
}
