import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/Bottom%20nav/bookmark.dart';
import 'package:news_app/auth/login.dart';
class islogein extends StatelessWidget {
  const islogein({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshort){
          if(snapshort.hasData)
          {
            return bookmark();
          }
          else
          {
            return login();
          }
        },
      ),
    );
  }
}
