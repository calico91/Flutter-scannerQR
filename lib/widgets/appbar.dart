import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text('Historial'),
      actions: [
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {},
        )
      ],
    );
  }
}
