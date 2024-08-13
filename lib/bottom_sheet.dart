import 'package:flutter/material.dart';


void showCustomBottomSheet (BuildContext context ){
  showModalBottomSheet(context: context, builder: (BuildContext context){
    return Container(
      height: 200,
      color: Color(0x00DF6352),

    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('Menu'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}