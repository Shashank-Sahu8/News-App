import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/view_all.dart';
import 'dart:math';
import '../modell/model.dart';
import '../modell/news.dart';
import '../modell/web view.dart';
import '../searching/search throw.dart';
import '../searching/search.dart';

class discover extends StatefulWidget {
  const discover({super.key});

  @override
  State<discover> createState() => _discoverState();
}

class _discoverState extends State<discover> {


  List<ArticleModel> articles1=[];
  List<ArticleModel> articles2=[];
  List<ArticleModel> articles3=[];
  List<ArticleModel> articles4=[];
  List<ArticleModel> articles5=[];
  bool loading=true;
  @override
  void initState(){
    getNews1();
    getNews2();
    getNews3();
    getNews4();
    getNews5();
    super.initState();
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


  String catname="Technology";
  List<String> catlist=[
    "Technology",
    "Entertainment",
    "Business",
    "Sports",
    "Health",
  ];

  int current_page=1;
  final controller=PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){}, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 10,),
        ],
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.filter_list_sharp,color: Colors.blueGrey,),),
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Discover",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600),),
                  Text("Latest news just for you",style: TextStyle(fontSize: 14,color:Theme.of(context).colorScheme.onSecondaryContainer),),
                ],),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 24,right: 24),
                child: InkWell(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>search()));},
                  child: Container(
                    height: 44,
                    width: 700,decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,borderRadius: BorderRadius.circular(30)),
                    child: Row(children: [
                      SizedBox(width: 15,),
                      Icon(Icons.search_rounded,color: Colors.blueGrey),
                      SizedBox(width: 10,),
                      Text("Search",style: TextStyle(color: Colors.blueGrey,fontSize: 16),)
                    ],),
                  ),
                ),
              ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("l",style: TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.w600,fontSize: 30),),
                      SizedBox(width: 4,),
                      Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                      Expanded(child: SizedBox(width:200 ,)),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 37,
                    child: ListView.builder(
                        itemCount: catlist.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              catname=catlist[index];
                              setState(() {
                                current_page=index+1;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right:5.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Center(child: Text(catlist[index].toString(),style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),)),
                                ),
                                decoration: BoxDecoration(
                                    color: catname!=catlist[index]?Colors.grey.shade400:Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),

                if(current_page==1)
                  SingleChildScrollView(child: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context,index)
                        {
                          return InkWell(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles1[index].url.toString())));},
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
                                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles1[index].urlimage.toString()),fit: BoxFit.fill)),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(child: Container(
                                        height: 100,width: 220,
                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(articles1[index].title.toString().length>50?articles1[index].title.toString().substring(0,50)+"...":articles1[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(articles2[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                                Text(articles1[index].author.toString().length<8?"~${articles1[index].author}":"~${articles1[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
                                              ],
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
                    )
                    ],
                  ),),)
                    // SingleChildScrollView(child: Container(child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [loading == true ? Center(
                    //     child: CircularProgressIndicator(
                    //       color: Colors.blueGrey,),) :
                    //   ListView.builder(
                    //       physics: NeverScrollableScrollPhysics(),
                    //       shrinkWrap: true,
                    //       itemCount: articles1.length,
                    //       itemBuilder: (context, index) {
                    //         return InkWell(
                    //           onTap: () {
                    //             Navigator.push(context, MaterialPageRoute(
                    //                 builder: (context) => web_view(
                    //                     url: articles1[index].url.toString())));
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Container(
                    //               height: 260,
                    //              child: Column(
                    //                children: [
                    //                  Container(
                    //                    height: 180,
                    //                    color: Colors.red,
                    //                  ),
                    //                  Container(
                    //                    height: 80,
                    //                   color: Colors.blue,
                    //                  )
                    //                ],
                    //              ),
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //   )
                    //   ],
                    // ),),)

                else if(current_page==2)
                  SingleChildScrollView(child: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context,index)
                        {
                          return InkWell(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles2[index].url.toString())));},
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
                                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles2[index].urlimage.toString()),fit: BoxFit.fill)),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(child: Container(
                                        height: 100,width: 220,
                                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(articles2[index].title.toString().length>50?articles2[index].title.toString().substring(0,50)+"...":articles2[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(articles2[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                                Text(articles2[index].author.toString().length<8?"~${articles2[index].author}":"~${articles2[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
                                              ],
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
                    )
                    ],
                  ),),)
                else if(current_page==3)
                    SingleChildScrollView(child: Container(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>view_all(length: articles3.length, url: articles3, imgurl: imgurl, title: title, description: description, author: author, time: time)))
                          }, child: Text("View all",style: TextStyle(color: Theme.of(context).colorScheme.tertiary,),)),
                          SizedBox(width: 5,)
                        ],),
                        loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context,index)
                          {
                            return InkWell(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles3[index].url.toString())));},
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
                                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles3[index].urlimage.toString()),fit: BoxFit.fill)),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(child: Container(
                                          height: 100,width: 220,
                                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text(articles3[index].title.toString().length>50?articles3[index].title.toString().substring(0,50)+"...":articles3[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(articles3[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                                  Text(articles3[index].author.toString().length<8?"~${articles3[index].author}":"~${articles3[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
                                                ],
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
                      )
                      ],
                    ),),)
                  else if(current_page==4)
                      SingleChildScrollView(child: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context,index)
                            {
                              return InkWell(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles4[index].url.toString())));},
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
                                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles4[index].urlimage.toString()),fit: BoxFit.fill)),
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(child: Container(
                                            height: 100,width: 220,
                                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(child: Text(articles4[index].title.toString().length>50?articles4[index].title.toString().substring(0,50)+"...":articles4[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(articles4[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                                    Text(articles4[index].author.toString().length<8?"~${articles4[index].author}":"~${articles4[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
                                                  ],
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
                        )
                        ],
                      ),),)
                    else if(current_page==5)
                        SingleChildScrollView(child: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                          children: [loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context,index)
                              {
                                return InkWell(
                                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: articles5[index].url.toString())));},
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
                                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles5[index].urlimage.toString()),fit: BoxFit.fill)),
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(child: Container(
                                              height: 100,width: 220,
                                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: Text(articles5[index].title.toString().length>50?articles5[index].title.toString().substring(0,50)+"...":articles5[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(articles4[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                                      Text(articles5[index].author.toString().length<8?"~${articles5[index].author}":"~${articles5[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
                                                    ],
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
                          )
                          ],
                        ),),)

            ],),
          ),
        ),
      ),
      
    );
  }
}
