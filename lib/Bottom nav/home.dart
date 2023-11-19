import 'package:animated_typing/animated_typing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_loadingkit/flutter_animated_loadingkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_plus/icons_plus.dart';

import '../navbar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        key: scaffoldKey,
      drawer: NavBar(),
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
          icon: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.menu,color: Colors.blueGrey,)),
          onPressed: (){
            if(scaffoldKey.currentState!.isDrawerOpen){
              scaffoldKey.currentState!.closeDrawer();
            }else{
              scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        iconTheme: IconThemeData(color: Colors.blueGrey),
        elevation: 0,
        title: Row(children: [
          Text("News",style: TextStyle(fontSize:26,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimaryContainer),),
          SizedBox(width: 4,),
          Text("Time",style: TextStyle(fontSize:28,fontWeight:FontWeight.w900,color: Theme.of(context).colorScheme.tertiary),)
        ],),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded,color: Colors.blueGrey,))),
          SizedBox(width: 6,),
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){}, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Container(child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Breaking News",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  TextButton(onPressed: (){}, child: Text("View all",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),))
                ],
              ),
            ),




            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recomendations",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  TextButton(onPressed: (){}, child: Text("View all",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),))
                ],
              ),
            )


          ],
        )
          ,),
      )
    );
  }
}




