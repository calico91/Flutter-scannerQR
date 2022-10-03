import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr/providers/provider.dart';
import 'package:qr/utils/utils.dart';



class ScanButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async { 

        String respuestaQR = await FlutterBarcodeScanner.scanBarcode('#3D8BEF','Cancelar',false,ScanMode.QR);
          // '#3D8BEF', 'Cancelar', false,  ScanMode.QR);
        //final respuestaQR= 'http://gitlab.com';
        //final respuestaQR= 'geo:3.383140,-76.527229';

        if(respuestaQR =='-1'){
          return;
        }
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        //scanListProvider.nuevoScan(respuestaQR);

        final nuevoScan = await scanListProvider.nuevoScan(respuestaQR);

        launchURL3(context,nuevoScan);
      },
      );
  }
}