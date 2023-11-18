import 'package:animated_typing/animated_typing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_loadingkit/flutter_animated_loadingkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.01,
        title: Row(children: [
          Text("News",style: TextStyle(fontSize:26,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimaryContainer),),
          SizedBox(width: 4,),
          Text("Time",style: TextStyle(fontSize:28,fontWeight:FontWeight.w900,color: Theme.of(context).colorScheme.tertiary),)
        ],),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.blueGrey,))
        ],
      ),
      body: Center(child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AnimatedTyping(
              //   text: 'News',
              //   duration: Duration(
              //     seconds: 1,
              //   ),
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //     color: Theme.of(context).colorScheme.onPrimaryContainer,
              //     fontSize: 30,
              //   ),
              // ),
              Text("News",style: TextStyle(fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 30,),),
              AnimatedTyping(
                text: 'Time',
                duration: Duration(seconds: 1,),
                style: TextStyle(
                    fontWeight:FontWeight.w900,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 32,
                ),

              ),

              // AnimatedLoadingHeartBeat(
              //   // expandWidth: 70,
              //   // borderColor: Colors.black,
              //   speed: Duration(milliseconds: 1000),
              // )
            ],
          ),
          SpinKitThreeInOut(
            color: Colors.green,
            size: 40.0,
          )
        ],
      ),),
    );
  }
}
