import 'dart:io';
//import 'dart:typed_data';

import 'package:proyecto_final/application_layer/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static const dbnamefile = 'persons_database';
  static const persontable = 'persons';
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, '$dbnamefile.db');
    //print('+==================Path=============');
    //print(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      return db.execute(
          'create table $persontable(nui text primary key, name text, cargo text,age integer, foto text, direccion text)');
    });
  }

  Future<List<Person>> getAllPersons() async {
    /*return Future.value([
      Person(
          nui: '180000',
          name: 'Juan Perez',
          age: 0,
          cargo: 'Sin Asignar',
          foto:
              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')
    ]);*/
    final db = await database;
    final response = await db!.query(persontable);
    List<Person> list = response.isNotEmpty
        ? response.map((person) => Person.fromJson(person)).toList()
        : [];
    return list;
  }

  Future<int> addPerson(Person person) async {
    final db = await database;
    final response = await db!.insert(persontable, person.toJson());
    return response;
  }

  Future<int> updatePerson(String nui, Person person) async {
    final db = await database;
    final response = db!
        .update(persontable, person.toJson(), where: 'nui=?', whereArgs: [nui]);
    return response;
  }

  Future<int> deletePerson(String nui, Person person) async {
    final db = await database;
    final response = db!.delete(persontable, where: 'nui=?', whereArgs: [nui]);
    return response;
  }
}
