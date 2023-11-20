import 'package:flutter/material.dart';
import 'package:news_app/searching/search%20data.dart';
import 'package:news_app/searching/search%20throw.dart';

import '../modell/model.dart';
import '../modell/news.dart';
import '../modell/web view.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  bool doc=false;
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        toolbarHeight: 40,
      ),
      body:
          Column(
            children: [

              Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if ((searchController.text).replaceAll(" ", "") ==
                                  "") {
                                print("Blank search");
                              } else {


                              }
                            },
                            child: Container(
                              child: Icon(
                                Icons.search,
                                color: Colors.blueGrey,
                              ),
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              cursorColor: Colors.blueGrey,
                              controller: searchController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>th(que: searchController.text.toString())));
                               // Navigator.replace(context, oldRoute: MaterialPageRoute(builder: (context)=>search()), newRoute: MaterialPageRoute(builder: (context)=>th(que: searchController.text.toString())));
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>th(que: searchController.text.toString())));
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Health",

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ]
              ),




            ],
          )
    );



  }
}
