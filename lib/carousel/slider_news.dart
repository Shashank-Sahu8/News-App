import 'dart:convert';
import 'package:news_app/modell/model.dart';
import 'package:http/http.dart'as http;
class SlidingNews{
  String qii="business";
  List<ArticleModel> news=[];

  Future<void>getNews()async{
    String url="https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=ca4b079379484fcb8a461cc10fa24537";
    var response=await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    if(jsonData['status']=='ok')
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null&&element['description']!=null&&element['title']!=null){
          ArticleModel articleModel=ArticleModel(
              title: element["title"],
              description: element["description"],
              author: element["author"],
              url: element["url"],
              urlimage: element["urlToImage"],
              content: element["content"],
              time: element["publishedAt"].toString().substring(0,10)
          );
          news.add(articleModel);
        }
      });
    }
  }
}