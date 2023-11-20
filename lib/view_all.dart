import 'package:flutter/material.dart';

class view_all extends StatefulWidget {
  int length;
  String url,imgurl,title,description,author,time;
  view_all({super.key,required this.length,required this.url,required this.imgurl,required this.title,required this.description,required this.author,required this.time});

  @override
  State<view_all> createState() => _view_allState();
}

class _view_allState extends State<view_all> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
