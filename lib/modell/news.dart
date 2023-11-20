import 'dart:convert';
import 'package:news_app/modell/model.dart';
import 'package:http/http.dart'as http;
class News{
  String ?qii;
  List<ArticleModel> news=[];
  News({required this.qii});
  Future<void>getNews()async{
    String url="https://newsapi.org/v2/top-headlines?country=us&category=$qii&apiKey=c2b8e8011bb94453862eb3e6a21cfeac";
    var response=await http.get(Uri.parse(url));
    var jsonData=jsonDecode(response.body);
    if(jsonData['status']=='ok')
      {
        jsonData["articles"].forEach((element){
          if(element["urlToImage"]!=null&&element['title']!=null){
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