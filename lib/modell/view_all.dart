import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';

import '../auth/if_login.dart';
import 'model.dart';
import 'news.dart';
import 'web view.dart';

class view_all extends StatefulWidget {
  int ind;String title;
  view_all({super.key,required this.ind,required this.title});

  @override
  State<view_all> createState() => _view_allState();
}
final _auth=FirebaseAuth.instance;
var time=DateTime.now();
String uid=_auth.currentUser!.uid;
List<String> temp=[];
class _view_allState extends State<view_all> {

  List<ArticleModel> article=[];
  List<ArticleModel> articles1=[];
  List<ArticleModel> articles2=[];
  List<ArticleModel> articles3=[];
  List<ArticleModel> articles4=[];
  List<ArticleModel> articles5=[];
  bool loading=true;
  @override
  void initState(){
    getNews();
    getNews1();
    getNews2();
    getNews3();
    getNews4();
    getNews5();
    super.initState();
  }

  getNews()async{
    loading=true;
    News newsclass=News(qii: "entertainment");
    await newsclass.getNews();
    article=newsclass.news;
    setState(() {
      loading=false;
    });
  }

  getNews1()async{
    loading=true;
    News newsclass=News(qii: "technology");
    await newsclass.getNews();
    articles1=newsclass.news;
    setState(() {
      loading=false;
    });
  }

  getNews2()async{
    loading=true;
    News newsclass=News(qii: "entertainment");
    await newsclass.getNews();
    articles2=newsclass.news;
    setState(() {
      loading=false;
    });
  }

  getNews3()async{
    loading=true;
    News newsclass=News(qii: "business");
    await newsclass.getNews();
    articles3=newsclass.news;
    setState(() {
      loading=false;
    });
  }

  getNews4()async{
    loading=true;
    News newsclass=News(qii: "sports");
    await newsclass.getNews();
    articles4=newsclass.news;
    setState(() {
      loading=false;
    });
  }

  getNews5()async{
    loading=true;
    News newsclass=News(qii: "health");
    await newsclass.getNews();
    articles5=newsclass.news;
    setState(() {
      loading=false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
        iconTheme:IconThemeData(color: Colors.blueGrey),
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>islogein()));}, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 5,)
        ],
        title: Text(widget.title,style: TextStyle(fontSize: 23,fontWeight:FontWeight.w500,color: Theme.of(context).colorScheme.onPrimaryContainer),),
      ),


      body:
      loading?Center(child: CircularProgressIndicator(color: Colors.blueGrey),):SingleChildScrollView(scrollDirection: Axis.vertical,
      child:
      Container(child: Column(children: [
        if(widget.ind==9)
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: article.length,
            itemBuilder: (context,index)
            {
              return InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: article[index].url.toString())));},
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
                                image: DecorationImage(image: NetworkImage(article[index].urlimage.toString()),fit: BoxFit.cover)
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
                                    child: Text(article[index].title.toString().length>50?article[index].title.toString().substring(0,50)+"...":article[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(article[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                      IconButton(onPressed: () async {
                                        print(uid.toString());
                                        var tt=DateTime.now();
                                        String ss=article[index].title.toString();
                                        await FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(ss.toString()).get().then((snapshot){if(snapshot.exists){setState(() {
                                          Fluttertoast.showToast(msg: 'Already Bookmarked');
                                        });}else{setState(() {
                                          Fluttertoast.showToast(msg: 'Bookmark Added');
                                        });}});
                                        await FirebaseFirestore.instance.collection('news').doc(uid).collection('liked').doc(ss.toString()).set({'likedtime':tt.toString(),'title':article[index].title.toString(),'url':article[index].url.toString(),'urlimage':article[index].urlimage.toString(),'time':article[index].time.toString()});
                                        setState(() {
                                          if(temp.contains(article[index].title.toString())==false)
                                          {
                                            temp.add(article[index].title.toString());
                                          }
                                        });
                                      }, icon: temp.contains(article[index].title.toString())?Icon(Icons.bookmark,color: Theme.of(context).colorScheme.tertiary,):Icon(Icons.bookmark_border_outlined,color: Colors.blueGrey,))
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
        )
        else if(widget.ind==1)
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: articles1.length,
              itemBuilder: (context,index)
              {
                return InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles1[index].url.toString())));},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 12.0,top:12.0,bottom: 6),
                    child: Card(
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 250.0,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                  image: DecorationImage(image: NetworkImage(articles1[index].urlimage.toString()),fit: BoxFit.cover)
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
                                      child: Text(articles1[index].title.toString().length>50?articles1[index].title.toString().substring(0,50)+"...":articles1[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(articles1[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                        Text(articles1[index].author.toString().length<8?"~${articles1[index].author}":"~${articles1[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
          )
        else if(widget.ind==2)
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles2.length,
                itemBuilder: (context,index)
                {
                  return InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles2[index].url.toString())));},
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
                                    image: DecorationImage(image: NetworkImage(articles2[index].urlimage.toString()),fit: BoxFit.cover)
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
                                        child: Text(articles2[index].title.toString().length>50?articles2[index].title.toString().substring(0,50)+"...":articles2[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(articles2[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                          Text(articles2[index].author.toString().length<8?"~${articles2[index].author}":"~${articles2[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
            )
          else if(widget.ind==3)
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles3.length,
                  itemBuilder: (context,index)
                  {
                    return InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles3[index].url.toString())));},
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
                                      image: DecorationImage(image: NetworkImage(articles3[index].urlimage.toString()),fit: BoxFit.cover)
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
                                          child: Text(articles3[index].title.toString().length>50?articles3[index].title.toString().substring(0,50)+"...":articles3[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(articles3[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                            Text(articles3[index].author.toString().length<8?"~${articles3[index].author}":"~${articles3[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
              )
            else if(widget.ind==4)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles4.length,
                    itemBuilder: (context,index)
                    {
                      return InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles4[index].url.toString())));},
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
                                        image: DecorationImage(image: NetworkImage(articles4[index].urlimage.toString()),fit: BoxFit.cover)
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
                                            child: Text(articles4[index].title.toString().length>50?articles4[index].title.toString().substring(0,50)+"...":articles4[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(articles4[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                              Text(articles4[index].author.toString().length<8?"~${articles4[index].author}":"~${articles4[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
                )
              else if(widget.ind==5)
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: articles5.length,
                      itemBuilder: (context,index)
                      {
                        return InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles5[index].url.toString())));},
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
                                          image: DecorationImage(image: NetworkImage(articles5[index].urlimage.toString()),fit: BoxFit.cover)
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
                                              child: Text(articles5[index].title.toString().length>50?articles5[index].title.toString().substring(0,50)+"...":articles5[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 8),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 4,),Text(articles5[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),)],),
                                                Text(articles5[index].author.toString().length<8?"~${articles5[index].author}":"~${articles5[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
                  )
      ],),),
      ),
    );
  }
}
