import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL( ScanModel scan) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    print('geo!!');
  }
}

launchURL2(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.valor);
  if (scan.tipo == 'http') {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  } else {
    print('geo!!');
  }
}

Future<void> launchURL3(BuildContext context, ScanModel scan) async {
  final Uri _url = Uri.parse(scan.valor);
  if (scan.tipo == 'http') {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }else{
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
