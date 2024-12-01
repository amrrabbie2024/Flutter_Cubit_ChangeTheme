import 'package:flutter/material.dart';

class MyHomeView extends StatelessWidget {
  const MyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Home page",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600)),
            SizedBox(height: 16,),
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back))
          ],
        ),
      ),
    );
  }
}
