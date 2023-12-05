import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
              print(docs.length);
              print(uid.toString());
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
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(docs[index]['title'].toString().length>80?docs[index]['title'].toString().substring(0,80)+"...":docs[index]['title'].toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(docs[index]['time'].toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                              IconButton(onPressed: () async {
                                                // print(uid.toString());
                                                // var tt=DateTime.now();
                                                // String ss=article[index].title.toString();
                                                // await FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(ss.toString()).get().then((snapshot){if(snapshot.exists){setState(() {
                                                //   Fluttertoast.showToast(msg: 'Already Bookmarked');
                                                // });}else{setState(() {
                                                //   Fluttertoast.showToast(msg: 'Bookmark Added');
                                                // });}});
                                                // await FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(ss.toString()).set({'likedtime':tt.toString(),'title':article[index].title.toString(),'url':article[index].url.toString(),'urlimage':article[index].urlimage.toString(),'time':article[index].time.toString()});
                                                // setState(() {
                                                //   if(temp.contains(article[index].title.toString())==false)
                                                //   {
                                                //     temp.add(article[index].title.toString());
                                                //   }
                                                // });
                                              }, icon:Icon(Icons.bookmark,color: Theme.of(context).colorScheme.tertiary,))
                                            ],
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
              );
            }}),
      ) ,
    );
  }
}
