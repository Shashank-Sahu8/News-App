import 'package:animated_typing/animated_typing.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/Bottom%20nav/home.dart';
import 'package:news_app/home_screen.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> home_page(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height:300,decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/newspaper-removebg-preview.png'))),),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTyping(
                text: 'News Time ...',
                duration: Duration(seconds: 1,),
                style: TextStyle(
                  fontWeight:FontWeight.w900,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 32,
                ),

              ),
            ],
          ),
          SpinKitSquareCircle(
            color: Colors.white24,
            size: 150.0,
          )
        ],
      ),),
    );
  }
}
