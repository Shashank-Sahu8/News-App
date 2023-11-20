import 'package:flutter/material.dart';
import 'package:news_app/carousel/slider_news.dart';

import '../modell/model.dart';
import '../modell/news.dart';

List<ArticleModel>slid=[];
getslidernews()async{
  SlidingNews newsclass=SlidingNews();
  await newsclass.getNews();
  slid=newsclass.news;
}