import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/Theme/themeprovider.dart';
import 'package:news_app/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
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








