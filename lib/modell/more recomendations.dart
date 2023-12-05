import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:news_app/modell/web%20view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/if_login.dart';
import '../carousel/slider data.dart';
import 'model.dart';
import 'news.dart';

class morerecomendations extends StatefulWidget {
  const morerecomendations({super.key});

  @override
  State<morerecomendations> createState() => _morerecomendationsState();
}
final _auth=FirebaseAuth.instance;
var time=DateTime.now();
String uid=_auth.currentUser!.uid;
List<String> temp=[];
class _morerecomendationsState extends State<morerecomendations> {

  List<ArticleModel> articles=[];
  bool loading=true;
  @override
  void initState() {
    getNews();
    getslidernews();
    super.initState();
  }
  getNews()async{
    News newsclass=News(qii: 'business');
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
        iconTheme:IconThemeData(color: Colors.blueGrey),
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>islogein()));}, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 5,)
        ],
        title: Text("Recomendations",style: TextStyle(fontSize: 23,fontWeight:FontWeight.w500,color: Theme.of(context).colorScheme.onPrimaryContainer),),
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:10 ,),
              Container(
                child: loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),):ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
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
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(articles[index].urlimage.toString()),fit: BoxFit.fill)),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(child: Container(
                                    height: 100,width: 220,
                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(articles[index].title.toString().length>50?articles[index].title.toString().substring(0,50)+"...":articles[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),),
                                        Expanded(
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,size: 19,),SizedBox(width: 3,),Text(articles[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                                              IconButton(onPressed: () async {
                                                print(uid.toString());
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
                                              }, icon: temp.contains(articles[index].title.toString())?Icon(Icons.bookmark,color: Theme.of(context).colorScheme.tertiary,):Icon(Icons.bookmark_border_outlined,color: Colors.blueGrey,))
                                            ],
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
              ),
            ],
          ),
        ),
      ),

    );

  }
}

