import 'package:flutter/material.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/Theme/themeprovider.dart';
import 'package:news_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(ChangeNotifierProvider(create:(context)=> ThemeProvider(),child:MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: Splash_Screen(),
      themeMode:ThemeMode.system,
      theme:Provider.of<ThemeProvider>(context).themeData,
    );
  }
}








