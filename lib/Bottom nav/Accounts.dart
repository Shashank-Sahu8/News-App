import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../Theme/themeprovider.dart';

class accounts extends StatefulWidget {
  const accounts({super.key});

  @override
  State<accounts> createState() => _accountsState();
}
final  _auth = FirebaseAuth.instance;
String? uid=_auth.currentUser?.uid;
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
      return _auth.currentUser!.displayName.toString();
    }
    else
    {
      return "No Name";
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
  Future userdata()async
  {
    QuerySnapshot querySnapshot=(await FirebaseFirestore.instance.collection('bookmark').doc(uid).collection('marks').doc('user').get()) as QuerySnapshot<Object?>;



    // DocumentReference docref=FirebaseFirestore.instance.collection('bookmark').doc(uid).collection('marks').doc('user');
    // DocumentSnapshot dd=await docref.get();
    // var s=dd.data.toString();
     return querySnapshot.docs;
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
                Text(getname(),style: TextStyle(color:Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w600,fontSize: 21))
                //Text(getname().toString(),style: TextStyle(fontSize: 18,color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w500),)
              ],),),
            ),
            // FirebaseFirestore.instance.collection('bookmark').doc(uid).collection("user").snapshots(),

            SizedBox(height: 10,),
            Container(
              child:Row(children: [
                    SizedBox(width: 20,),
                    CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
                    SizedBox(width: 20,),
                    Text(userdata().toString(),style: TextStyle(color: Colors.blueGrey,fontSize: 17))
                  ],) ,
              // child: StreamBuilder(
              //   stream: FirebaseFirestore.instance.collection('bookmark').doc(uid).collection("marks").doc('user').collection('user_mail').snapshots(),
              //   builder: (context,snapshots){
              //   if(snapshots.connectionState==ConnectionState.waiting)
              //   {
              //       return const Center(child:CircularProgressIndicator(),);
              //   }
              //   else {
              //     final docs = snapshots.data?.docs;
              //     return  Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15,),
              //       child: ListView.builder(
              //           itemCount: docs?.length,
              //           itemBuilder: (context,index){
              //             return Text(docs!.length.toString(),style: TextStyle(color: Colors.black),);
              //             // return Row(children: [
              //             //       SizedBox(width: 20,),
              //             //       CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
              //             //       SizedBox(width: 20,),
              //             //       //Text("hello",style: TextStyle(color: Colors.blueGrey,fontSize: 17))
              //             //     ],);
              //           }),
              //     );
              //   }
              //   },
              // )
            ),
        //       else
        //       {
        //         return Row(children: [
        //           SizedBox(width: 20,),
        //           CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
        //           SizedBox(width: 20,),
        //           Text("Invalid email",style: TextStyle(color: Colors.blueGrey,fontSize: 17))
        //         ],);
        //       }
        //     }
        // ),
        // StreamBuilder(stream:FirebaseFirestore.instance.collection('bookmark').doc(uid).collection("user").snapshots(),
        //           builder: (context,snapshots){
        //             final docs=snapshots.data!.docs;
        //             return snapshots.hasData?Row(children: [
        //               SizedBox(width: 20,),
        //               CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
        //               SizedBox(width: 20,),
        //               Text("has email",style: TextStyle(color: Colors.blueGrey,fontSize: 17))
        //             ],):Row(children: [
        //             SizedBox(width: 20,),
        //             CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
        //             SizedBox(width: 20,),
        //             Text("Invalid email",style: TextStyle(color: Colors.blueGrey,fontSize: 17))
        //             ],);
        //             // if(snapshots.hasData)
        //             // {
        //             // return Text(docs[0]['user_mail'].toString());
        //             // }
        //             return Row(children: [
        //               SizedBox(width: 20,),
        //               CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
        //               SizedBox(width: 20,),
        //               Text("Invalid email",style: TextStyle(color: Colors.blueGrey,fontSize: 17))
        //             ],);
        //           // }
        //           // else
        //           // {
        //           // final docs=snapshots.data!.docs;
        //           // return Row(children: [
        //           // SizedBox(width: 20,),
        //           // CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: Icon(Icons.mail_outline_outlined,color: Colors.blueGrey,)),
        //           // SizedBox(width: 20,),
        //           // Text(docs[1]['mail'].toString(),style: TextStyle(color: Colors.blueGrey,fontSize: 17))
        //           // ],);
        //           // }
        // }),
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
              onTap: (){
                //FirebaseFirestore.instance.collection('bookmark').doc(uid).collection('marks').doc('user').delete();
                _auth.signOut();
                utils().toastmess("Successful Log Out");
                setState(() {

                });
              },
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




