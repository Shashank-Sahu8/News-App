import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
String i="";
class web_view extends StatefulWidget {
  String url;
   web_view({super.key,required this.url});

  @override
  State<web_view> createState() => _web_viewState();
}

class _web_viewState extends State<web_view> {
  @override
  Widget build(BuildContext context) {
    WebViewController controller=WebViewController()
      ..setJavaScriptMode((JavaScriptMode.unrestricted))
      ..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: Colors.blueGrey),

        elevation: 0,
        title: Row(children: [
          Text("News",style: TextStyle(fontSize:26,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimaryContainer),),
          SizedBox(width: 4,),
          Text("Time",style: TextStyle(fontSize:28,fontWeight:FontWeight.w900,color: Theme.of(context).colorScheme.tertiary),)
        ],),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,child: IconButton(onPressed: (){}, icon: Icon(FontAwesome.bell,color: Colors.blueGrey,))),
          SizedBox(width: 10,),
        ],
      ),
      body: SafeArea(child: WebViewWidget(controller: controller,)),
    );
  }
}
