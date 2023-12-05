import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/auth/login.dart';

import '../auth/if_login.dart';
import '../modell/web view.dart';

class bookmark extends StatefulWidget {
  const bookmark({super.key});

  @override
  State<bookmark> createState() => _bookmarkState();
}
final  _auth = FirebaseAuth.instance;
String uid=_auth.currentUser!.uid;
class _bookmarkState extends State<bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CircleAvatar(backgroundColor:Theme.of(context).colorScheme.secondary ,child: Icon(Icons.delete_forever,color: Colors.blueGrey,)),
          onPressed: (){
            FirebaseFirestore.instance.collection('news').doc(uid).delete();
            Fluttertoast.showToast(msg: 'All bookmark removed');
          },
        ),
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
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').snapshots(),
          builder: (context,snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.black,),);
            }
            else {
              final docs = snapshots.data!.docs;
              if(docs.length==0)
                {
                  return Center(child: Text("No bookmark added yet +",style: TextStyle(color: Colors.grey,fontSize: 19,fontWeight: FontWeight.w400),),);
                }
              else
                {
                return Padding(padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15,),
                  child: ListView.builder(
                      itemCount: docs.length,
                      shrinkWrap: true,
                      itemBuilder:(context,index){
                       // return Center(child: Text(docs.length.toString()),);
                         return InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url:docs[index]['url'].toString())));},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0,top:12.0,bottom: 6),
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                height: 250.0,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.background,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          image: DecorationImage(image: NetworkImage(docs[index]['urlimage'].toString()),fit: BoxFit.cover)
                                      ),
                                      height: 160,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.background,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                      ),
                                      height: 90,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                                            child: Text(docs[index]['title'].toString().length>50?docs[index]['title'].toString().substring(0,50)+"...":docs[index]['title'].toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,size: 19,),SizedBox(width: 4,),Text(docs[index]['time'].toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                                  IconButton(onPressed: ()  {
                                                    FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(docs[index]['title']).delete();
                                                    Fluttertoast.showToast(msg: 'Bookmark removed');
                                                  }, icon:Icon(Icons.delete,color: Theme.of(context).colorScheme.tertiary,))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ) ;
                    }
                ),
              );}
            }}),
      ) ,
    );
  }
}
