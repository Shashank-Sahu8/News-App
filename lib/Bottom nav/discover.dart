import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../search.dart';

class discover extends StatefulWidget {
  const discover({super.key});

  @override
  State<discover> createState() => _discoverState();
}

class _discoverState extends State<discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){}, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Discover",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600),),
                  Text("Latest news just for you",style: TextStyle(fontSize: 14,color:Theme.of(context).colorScheme.onSecondaryContainer),),
                ],),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 24,right: 24),
                child: InkWell(
                  onTap: (){showSearch(context: context, delegate: Search());},
                  child: Container(
                    height: 44,
                    width: 700,decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,borderRadius: BorderRadius.circular(30)),
                    child: Row(children: [
                      SizedBox(width: 15,),
                      Icon(Icons.search_rounded,color: Colors.blueGrey),
                      SizedBox(width: 10,),
                      Text("Search",style: TextStyle(color: Colors.blueGrey,fontSize: 16),)
                    ],),
                  ),
                ),
              )
            ],),
          ),
        ),
      ),
      
    );
  }
}
