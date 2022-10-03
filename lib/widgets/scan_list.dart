import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/utils/utils.dart';

import '../providers/provider.dart';

class ScanList extends StatelessWidget {
  final String tipo;

  const ScanList(this.tipo);

  @override
  Widget build(BuildContext context) {

    final scanList = (Provider.of<ScanListProvider>(context)).scans;

    return ListView.builder(
      itemCount: scanList.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Theme.of(context).primaryColor),
        onDismissed: (DismissDirection dismissDirection) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteById(scanList[i].id!);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.compass_calibration : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scanList[i].valor),
          subtitle: Text(scanList[i].id.toString()),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => launchURL3( _ , scanList[i]),
        ),
      ),
    );
  }
}
