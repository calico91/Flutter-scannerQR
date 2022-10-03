import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr/providers/provider.dart';
import 'package:qr/screens/home_screen.dart';
import 'package:qr/screens/map_screen.dart';



void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> new UiProvider()),
        ChangeNotifierProvider(create: (_)=> new ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR',
        initialRoute: 'home',
        routes: {
          'home':(_)=>HomeScreen(),
          'map':(_)=> MapScreen(),
        },
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo
          ),
          primaryColor: Colors.indigo,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo
          )
        ),
      ),
    );
  }
}