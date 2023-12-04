import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/auth/login.dart';

import '../auth/if_login.dart';

class bookmark extends StatefulWidget {
  const bookmark({super.key});

  @override
  State<bookmark> createState() => _bookmarkState();
}
final  _auth = FirebaseAuth.instance;

class _bookmarkState extends State<bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
        iconTheme:IconThemeData(color: Colors.blueGrey),
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){
            _auth.signOut();
          utils().toastmess("Successful Log Out");}, icon: Icon(Icons.logout_rounded,color: Colors.blueGrey,))),
          SizedBox(width: 8,)
        ],
        title: Text("Book Marks",style: TextStyle(fontSize: 27,fontWeight:FontWeight.w600,color: Theme.of(context).colorScheme.onPrimaryContainer),),
      ),

      body: ,
    );
  }
}
