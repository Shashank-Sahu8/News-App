import 'package:flutter/material.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Something went wrong",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/pendingimages.png',) )),
            ),
            SizedBox(height: 200,),

            Text("Developer - Shashank Sahu")
          ],
        ),
      ),
    );
  }
}
