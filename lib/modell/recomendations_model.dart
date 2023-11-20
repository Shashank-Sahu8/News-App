import 'package:flutter/material.dart';
import 'package:news_app/modell/web%20view.dart';

class recomwidget extends StatelessWidget {
  String img,title,des,url,time,author;
  recomwidget({super.key,required this.title,required this.time,required this.url,required this.des,required this.img,required this.author});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>web_view(url: url)));},
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
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,borderRadius: BorderRadius.circular(7),image: DecorationImage(image: NetworkImage(img),fit: BoxFit.fill)),
              ),
              SizedBox(width: 10,),
              Expanded(child: Container(
                height: 100,width: 220,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title.length>50?title.substring(0,50)+"...":title,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400 ),)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [Icon(Icons.watch_later_rounded,color: Colors.blueGrey,),SizedBox(width: 3,),Text(time,style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,),)],),
                        Text(author.length<8?"~$author":"~${author.substring(0,8)+".."}",style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer,fontSize: 14),)
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
}
