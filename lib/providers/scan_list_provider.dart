import 'package:flutter/material.dart';
import 'package:qr/providers/provider.dart';
import '../models/scan_model.dart';


class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado ='http';

  Future<ScanModel> nuevoScan(String valor) async{
    //instancia del modelo
    final nuevoScan = new ScanModel(valor: valor);
    //insertar dato en bd y regresa id de la base de datos
    final id = await DBProvider.db.nuevoScan(nuevoScan);  
    //asignar el ID de la base de datos al modelo
    nuevoScan.id=id;

    if(this.tipoSeleccionado==nuevoScan.tipo){
      //se guarda en la lista segun el tipo
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  upLoadScans() async{
    final scans = await DBProvider.db.getAllScan();
    //agrega los resultados y genera una nueva lista 
    this.scans =[...scans!];
    notifyListeners();
  }

  upLoadByTipoScans(String tipo) async{
    final scans = await DBProvider.db.getScanByTipo(tipo);
    //agrega los resultados y genera una nueva lista 
    this.scans =[...scans!];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  deleteAllScans() async{
    final scans = await DBProvider.db.deleteAllScan();
    //agrega los resultados y genera una nueva lista 
    this.scans =[];
    notifyListeners();
  }
  deleteById(int id) async{
    await DBProvider.db.deleteScan(id);
    this.upLoadByTipoScans(this.tipoSeleccionado);
 
  }
}