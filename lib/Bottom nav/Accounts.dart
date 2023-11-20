import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../Theme/themeprovider.dart';

class accounts extends StatefulWidget {
  const accounts({super.key});

  @override
  State<accounts> createState() => _accountsState();
}

class _accountsState extends State<accounts> {

  final FirebaseAuth _auth=FirebaseAuth.instance;
  getpp()
  {
    if(_auth.currentUser?.photoURL!=null)
    {
      return NetworkImage(_auth.currentUser!.photoURL.toString());
    }
    else
    {
      return AssetImage('assets/per-removebg-preview.png');
    }
  }

  getname()
  {
    if(_auth.currentUser?.displayName!=null)
    {
      return Text(_auth.currentUser!.displayName.toString(),style: TextStyle(color:Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w600,fontSize: 21));
    }
    else
    {
      return Text("No Name",style: TextStyle(color:Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w600,fontSize: 21,));
    }
  }
  getemail()
  {
    if(_auth.currentUser?.email!=null)
    {
      return Text(_auth.currentUser!.email.toString(),style: TextStyle(color: Colors.blueGrey,fontSize: 17));
    }
    else
    {
      return Text("Invalid email",style: TextStyle(color: Colors.blueGrey,fontSize: 17));
    }
  }

  bool status=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        //appBar: AppBar(elevation:0,title: Text("Accounts"),backgroundColor: Theme.of(context).colorScheme.primary,),
        body: Column(
          children: [
            Container(
              height: 250,
              color: Theme.of(context).colorScheme.secondary,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 17,),
                CircleAvatar(
                    radius: 50,
                    backgroundColor:Theme.of(context).colorScheme.primary,
                    backgroundImage: getpp(),
                  //child: Image(image: NetworkImage(getpp()),),
                ),
                SizedBox(height: 5,),
                getname()
                //Text(getname().toString(),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w500),)
              ],),),
            ),
            SizedBox(height: 10,),
            Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              getemail()
             // Text(getemail().toString(),style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.onPrimaryContainer),)
            ],),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){},
              child: Row(children: [
                SizedBox(width: 20,),
                CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.edit,color: Colors.blueGrey,)),
                SizedBox(width: 20,),
                Text("Edit Profile",style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.onPrimaryContainer),),
                Expanded(child: SizedBox(width: 100,)),
                Icon(Icons.arrow_forward_ios_sharp,color: Colors.blueGrey,size: 15,),
                SizedBox(width: 10,)
              ],),
            ),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){_auth.signOut();
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Logged Out',
              );},
              child: Row(children: [
                SizedBox(width: 20,),
                CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.logout,color: Colors.blueGrey,)),
                SizedBox(width: 20,),
                Text("LogOut",style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.onPrimaryContainer),),
                Expanded(child: SizedBox(width: 100,)),
                Icon(Icons.arrow_forward_ios_sharp,color: Colors.blueGrey,size: 15,),
                SizedBox(width: 10,)
              ],),
            ),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Settings",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500 ),),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Row(children: [
              SizedBox(width: 20,),
              CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.sunny,color: Colors.blueGrey,)),
              SizedBox(width: 20,),
              Text("Theme",style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.onPrimaryContainer),),
              Expanded(child: SizedBox(width: 100,)),
              FlutterSwitch(
                width: 70.0,
                height: 30.0,
                valueFontSize: 10.0,
                toggleSize: 24.0,
                 activeText: 'Light',
                 inactiveText: 'Dark',
                 activeIcon: Icon(Bootstrap.sun,color: Colors.orangeAccent,size: 400,),
                 inactiveIcon: Icon(FontAwesomeIcons.moon,color:Colors.grey.shade800,size: 400,),
                 value: status,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,activeColor: Theme.of(context).colorScheme.tertiary,
                onToggle: (val) {
                  setState(() {
                    Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                    status=val;
                  });
                },
              ),

              SizedBox(width: 10,)
            ],),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 5,),


          ],
        )
    );
  }
}




