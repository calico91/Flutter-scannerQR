import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/providers/ui_provider.dart';

class BottomNavigator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectMenuOpt;

    return BottomNavigationBar(
      onTap: (int i)=> uiProvider.selectMenuOpt=i,
      currentIndex: currentIndex,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa'),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Urls'),
        
      ],

    );
  }
}