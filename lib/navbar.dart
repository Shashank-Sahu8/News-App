import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/Bottom%20nav/bookmark.dart';
import 'package:open_share_plus/open.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Bottom nav/Accounts.dart';
import 'auth/if_login.dart';

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
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>islogein()));},
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
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>accounts()));},
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
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>accounts()));},
            child: Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.settings,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("Settings",style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
          ),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){
              Open.mail(toAddress: "shashanksahu87070@gmail.com", subject: "email to the developer of News Time", body: "Thanks for this app");
            },
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
            onTap: (){
              launch("https://www.facebook.com/");
            },
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
          InkWell(onTap: (){
            launch("https://twitter.com/i/flow/login?input_flow_data=%7B%22requested_variant%22%3A%22eyJsYW5nIjoiZW4ifQ%3D%3D%22%7D");
          },
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
