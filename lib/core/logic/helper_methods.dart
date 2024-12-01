import 'package:flutter/material.dart';

final navigtorKey=GlobalKey<NavigatorState>();

/*void navigateTo(Widget page){
  Navigator.push(navigtorKey.currentContext!, MaterialPageRoute(builder: (context) => page,));
}*/

void navigateTo(Widget page,{bool withHistory=true}){
  Navigator.pushAndRemoveUntil(navigtorKey.currentContext!, MaterialPageRoute(builder: (context) => page,),(route) => withHistory,);
}

void showMessage(String msg,{bool isSucess=false}){
  if(msg != null) {
    ScaffoldMessenger.of(navigtorKey.currentContext!).showSnackBar(SnackBar(
        backgroundColor: isSucess == true ? Colors.green : Colors.red,

        content: Center(child: Text(msg))));
  }
}