import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(height: 200,color: Theme.of(context).colorScheme.secondary,
          child: Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("News",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimaryContainer),),
                SizedBox(width: 4,),
                Text("Time",style: TextStyle(fontSize:32,fontWeight:FontWeight.w900,color: Theme.of(context).colorScheme.tertiary),)
              ],),
              Text("Latest News",style: GoogleFonts.barlow(fontSize: 15,color: Theme.of(context).colorScheme.onSecondaryContainer),)
            ],
          ),),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){},
            child: Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.bookmark,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("Bookmark",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
          ),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){},
            child: Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("User",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
          ),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){},
            child: Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.bookmark,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("Contact Us",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
          ),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){},
            child: Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Bootstrap.facebook,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("Facebook Page",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
          ),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 5,),
          InkWell(onTap: (){},
            child: Row(children: [
              SizedBox(width:20 ,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Bootstrap.twitter,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("Twitter",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
          ),

        ],
      ),
    );
  }
}
