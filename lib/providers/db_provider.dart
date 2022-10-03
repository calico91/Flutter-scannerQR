import 'dart:io';
import 'package:path/path.dart';
import 'package:qr/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  //mantener la instancia de bd
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    //path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansBD.db');
    print(path);

    //crear bd
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

  // primer metodo insertar datos a bd
  // Future <int> nuevoScanRaw(ScanModel nuevoScan) async{
  //   final id = nuevoScan.id;
  //   final tipo = nuevoScan.tipo;
  //   final valor = nuevoScan.valor;

  //   //verifica si la bd ya esta creada,
  //   final db = await database;
  //   final respuesta = await db!.rawInsert('''
  //     INSERT INTO scans (id,tipo,valor)
  //       VALUES ($id,'$tipo','$valor')
  //     ''');

  //   return respuesta;
  // }

  // segundo metodo insertar datos a bd
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final respuesta = await db!.insert('scans', nuevoScan.toJson());
    return respuesta;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final respuesta = await db!.query('scans', where: 'id=?', whereArgs: [id]);

    //print(respuesta.toString());
    return respuesta.isNotEmpty ? ScanModel.fromJson(respuesta.first) : null;
  }

  Future<List<ScanModel>?> getAllScan() async {
    final db = await database;
    final respuesta = await db!.query('scans');

    //print(respuesta.toString());
    return respuesta.isNotEmpty
        ? respuesta.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  Future<List<ScanModel>?> getScanByTipo(String tipo) async {
    final db = await database;
    final respuesta = await db!.rawQuery('''
        SELECT * FROM scans WHERE tipo ='$tipo'
        ''');
    return respuesta.isNotEmpty
        ? respuesta.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  Future<int?> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final respuesta = await db!.update('scans', nuevoScan.toJson(),
        where: 'id=?', whereArgs: [nuevoScan.id]);
    return respuesta;
  }

  Future<int?> deleteScan(int id) async {
    final db = await database;
    final respuesta = await db!.delete('scans', where: 'id=?', whereArgs: [id]);
    return respuesta;
  }

  Future<int?> deleteAllScan() async {
    final db = await database;
    final respuesta = await db!.delete('scans');
    return respuesta;
  }
  
}
