import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/searching/search%20data.dart';
import '../auth/if_login.dart';
import '../modell/model.dart';
import '../modell/news.dart';
import '../modell/web view.dart';

class th extends StatefulWidget {
  String? que;
   th({super.key,required this.que});

  @override
  State<th> createState() => _thState();
}
final _auth=FirebaseAuth.instance;
var time=DateTime.now();
String uid=_auth.currentUser!.uid;
List<String> temp=[];
class _thState extends State<th> {

  List<ArticleModel> articles=[];
  bool loading=true;
  @override
  void initState(){
    getNews();
    super.initState();
  }

  getNews()async{
    loading=true;
    SearchNews newsclass=SearchNews(qii: widget.que.toString());
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
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        toolbarHeight: 55,
      ),

      body:loading==true?Center(child: CircularProgressIndicator(color: Colors.blueGrey,),): articles.length==0?Center(child: Text("No such result found...",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),),):SingleChildScrollView(
        child: Container(
          child:Column(
            children: [ListView.builder(
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
                                    Expanded(child: Text(articles[index].title.toString().length>50?articles[index].title.toString().substring(0,50)+"...":articles[index].title.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.start,
                                          children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(articles[index].time.toString(),style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
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
            )],
          ) ,
        ),
      ),
    );
  }
}
