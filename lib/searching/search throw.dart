import 'package:flutter/material.dart';
import 'package:news_app/searching/search%20data.dart';
import '../modell/model.dart';
import '../modell/news.dart';
import '../modell/web view.dart';

class th extends StatefulWidget {
  String? que;
   th({super.key,required this.que});

  @override
  State<th> createState() => _thState();
}

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
                                        Text(articles[index].author.toString().length<8?"~${articles[index].author}":"~${articles[index].author.toString().substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
