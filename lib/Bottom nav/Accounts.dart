import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Theme/themeprovider.dart';

class accounts extends StatefulWidget {
  const accounts({super.key});

  @override
  State<accounts> createState() => _accountsState();
}

class _accountsState extends State<accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(elevation:0,title: Text("Accounts"),backgroundColor: Theme.of(context).colorScheme.primary,),
      body: Row(
        children: [
          Container(height: 200,width: 200,color: Theme.of(context).colorScheme.secondary,),
          Center(
          child: ElevatedButton(onPressed: (){
            //notificationServices.sendNotification();
            Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
          },style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary, ),child: Text("click",style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),),
    ),),
        ],
      )
    );
  }
}
