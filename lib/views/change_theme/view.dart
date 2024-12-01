import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_changetheme/views/home/view.dart';

import '../../features/change_theme/cubit.dart';

class ChangeThemeView extends StatefulWidget {
  const ChangeThemeView({super.key});

  @override
  State<ChangeThemeView> createState() => _ChangeThemeViewState();
}

class _ChangeThemeViewState extends State<ChangeThemeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dark & Light Themes"),
        actions: [
          IconButton(onPressed: () {
            BlocProvider.of<ChangeThemesCubit>(context).changeMyAppTheme();
          }, icon: Icon(Icons.dark_mode))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Change App theme",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
            SizedBox(height: 16,),
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomeView(),));
            }, icon: Icon(Icons.arrow_forward))
          ],
        ),
      ),
    );
  }
}
