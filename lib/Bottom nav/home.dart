import 'dart:convert';
import 'package:animated_typing/animated_typing.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_loadingkit/flutter_animated_loadingkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/auth/if_login.dart';
import 'package:news_app/auth/login.dart';
import 'package:news_app/modell/model.dart';
import 'package:news_app/modell/more%20recomendations.dart';
import 'package:news_app/modell/more_slider.dart';
import 'package:news_app/modell/news.dart';
import 'package:news_app/modell/recomendations_model.dart';
import 'package:news_app/searching/search.dart';
import 'package:news_app/modell/view_all.dart';
import '../navbar.dart';
import 'package:flutter_html/flutter_html.dart';

import '../carousel/slider data.dart';
import '../modell/web view.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}
final _auth=FirebaseAuth.instance;
var time=DateTime.now();
String uid=_auth.currentUser!.uid;

class _homeState extends State<home> {
  // bool bm=false;
  List<ArticleModel> articles=[];
  bool loading=true;
  @override
  void initState(){
    getNews();
    getslidernews();
    super.initState();
  }

  getNews()async{
    loading=true;
    News newsclass=News(qii: "business");
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
      loading=false;
    });
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List items=[Colors.blue,Colors.pink,Colors.red];
  bool bm=false;
  List<String> temp=[];

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
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>search()));}, icon: Icon(Icons.search_rounded,color: Colors.blueGrey,))),
          SizedBox(width: 6,),
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>islogein()));
            }, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 10,),
        ],
      ),
      body:  loading?Center(child: CircularProgressIndicator(color: Colors.blueGrey),):SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Container(child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("l",style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w600,fontSize: 30),),
                  SizedBox(width: 4,),
                  Text("Breaking News",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  Expanded(child: SizedBox(width:200 ,)),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>view_all(ind: 9, title: "Breaking News")));}, child: Text("View all",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),))
                ],
              ),
            ),


            CarouselSlider.builder(
              itemCount: slid.length,
              options: CarouselOptions(
                  height: 230,
                  enlargeCenterPage: true,
                  enlargeStrategy:CenterPageEnlargeStrategy.height,
                  autoPlay: true,


              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final res= slid[index].urlimage;
                final res1=slid[index].title;
                final res2=slid[index].url;
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: res2!)));
                    },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image:DecorationImage(image: NetworkImage(res!),fit: BoxFit.cover,),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            // child: Image(image: NetworkImage(image),fit: BoxFit.cover,),
                          ),
                          Container(height: 70,width: 1000,
                            margin: EdgeInsets.only(top: 160),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(res1!.length>35?res1!.substring(0,35)+"...":res1!,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w400,color: Colors.white ),),
                            ),
                          )

                        ]
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("l",style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w600,fontSize: 30),),
                  SizedBox(width: 4,),
                  Text("Recomendations",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  Expanded(child: SizedBox(width:200 ,)),
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>morerecomendations()));}, child: Text("View all",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),))
                ],
              ),
            ),
            // Text(articles.length.toString())
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context,index)
                {
                  return InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles[index].url.toString())));},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Row(
                            children: [
                              Container(
                                height: 90,width: 100,
                                decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles[index].urlimage.toString()),fit: BoxFit.cover)),
                              ),
                              SizedBox(width: 10,),
                              Expanded(child: Container(
                                height: 100,width: 220,
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(articles[index].title.toString().length>50?articles[index].title.toString().substring(0,50)+"...":articles[index].title.toString(),style: TextStyle(fontSize: 17,fontWeight:FontWeight.w400 ),),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:10.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.watch_later_rounded,color: Colors.blueGrey,size: 19,),SizedBox(width: 3,),Text(articles[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                            IconButton(onPressed: ()  async {
                                              if(FirebaseAuth.instance.currentUser == null)
                                                {
                                                 // showDialog(context: context, builder:(BuildContext){return AlertDialog(title: Text("Alert"),content:Text("You are not logged in") ,actions: [ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.tertiary),onPressed: (){   Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));}, child: Text("Login"))],);});
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType: DialogType.infoReverse,
                                                      animType: AnimType.rightSlide,
                                                    title: "Alert",
                                                    desc: "You are not logged in",
                                                    btnCancelText: "Login",
                                                    btnOkOnPress: (){},
                                                      btnOkColor: Colors.redAccent,
                                                      btnOkText: "It's ok",
                                                    //btnCancel: Center(child: Text("Login"),),
                                                    btnCancelColor: CupertinoColors.systemGreen,
                                                    btnCancelOnPress: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>islogein()));}
                                                  )..show();
                                                }
                                              else {
                                                var tt=DateTime.now();
                                                String ss=articles[index].title.toString();
                                                await FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(ss.toString()).get().then((snapshot){if(snapshot.exists){setState(() {
                                                  Fluttertoast.showToast(msg: 'Already Bookmarked');
                                                });}else{setState(() {
                                                  Fluttertoast.showToast(msg: 'Bookmark Added');
                                                });}});
                                                await FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(ss.toString()).set({'likedtime':tt.toString(),'title':articles[index].title.toString(),'url':articles[index].url.toString(),'urlimage':articles[index].urlimage.toString(),'time':articles[index].time.toString()});
                                                setState(() {
                                                  if(temp.contains(articles[index].title.toString())==false)
                                                  {
                                                    temp.add(articles[index].title.toString());
                                                  }
                                                });
                                              }
                                            }, icon: temp.contains(articles[index].title.toString())?Icon(Icons.bookmark,color: Theme.of(context).colorScheme.tertiary,):Icon(Icons.bookmark_border_outlined,color: Colors.blueGrey,))
                                            // Text(articles[index].author.toString().length<8?"~${articles[index].author}":"~${articles[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ],),),
                        ),
                      ),
                    ),
                  ) ;
                }
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>morerecomendations()));}, icon: Icon(FontAwesome.arrows_rotate))],),
            ),
            SizedBox(height: 20,)


          ],
        )
          ,),
      )
    );
  }
}

//
// Widget buildimg(String image,int index,String name,String url)=>Container(
//   child: InkWell(
//     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: url)));},
//     child: Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 image:DecorationImage(image: NetworkImage(image),fit: BoxFit.cover,),
//                 borderRadius: BorderRadius.circular(10)
//             ),
//            // child: Image(image: NetworkImage(image),fit: BoxFit.cover,),
//           ),
//           Container(height: 70,width: 1000,
//             margin: EdgeInsets.only(top: 130),
//             decoration: BoxDecoration(
//                 color: Colors.black26,
//                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10))
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(name.length>35?name.substring(0,35)+"...":name,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w400,color: Colors.white ),),
//             ),
//           )
//
//     ]
//       ),
//     ),
//   ),
// );





