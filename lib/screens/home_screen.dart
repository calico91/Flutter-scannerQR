
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/screens/map_screen.dart';
import 'package:qr/widgets/bottom_navigator.dart';
import 'package:qr/widgets/scan_button.dart';
import 'package:qr/providers/provider.dart';
import 'package:qr/widgets/scan_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              final deleteScan =
                  Provider.of<ScanListProvider>(context, listen: false);
              deleteScan.deleteAllScans();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectMenuOpt;
    //insertar datos
    //final tempScan = new ScanModel(valor: 'http://google.com');
    //DBProvider.db.nuevoScan(tempScan); //insertar
    //DBProvider.db.getScanById(1).then((scan) => print(scan.toString())); //consultar

    //DBProvider.db.getScanById(9);

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.upLoadByTipoScans('geo');
        return ScanList('geo');

      case 1:
        scanListProvider.upLoadByTipoScans('http');
        return ScanList('http');

      default:
        return MapScreen();
    }
  }

  // void metodoPrueba() async {
  //   DBProvider.db.getAllScan().then((value) => print(value.toString()));
  //   final consulta = await DBProvider.db.getAllScan();

  //   for (var element in consulta ?? []) {
  //     print('-- Metodo de prueba --');
  //     print(element.id);
  //     print(element.tipo);
  //     print(element.valor);
  //   }
  // }

}
