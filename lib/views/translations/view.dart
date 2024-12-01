import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit_changetheme/core/logic/cash_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

final languages=["English","Arabic","French"];
final languagesCodes=["en","ar","fr"];
int currentIndex=0;
String? language;

class _ChangeLanguageViewState extends State<ChangeLanguageView> {

  @override
  void initState() {
    language=CashHelper.getLanguage();
    if(language =="en")
      currentIndex=0;
    else if(language == "ar")
      currentIndex=1;
    else if(language == "fr")
      currentIndex=2;
    else
      currentIndex=0;
   /* setState(() {
      context.setLocale(Locale(languagesCodes[currentIndex]));
    });*/
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("change_language".tr()),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 30,fontWeight:  FontWeight.bold),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 32.h),
        child: Column(
          children: [
            ...List.generate(languages.length, (index) => _item(index))
          ],
        ),
      ),
    );
  }

  Widget _item(int index){
    return Row(
      children: [
        Radio(value: currentIndex, groupValue: index, onChanged: (value) {
          setState(() {
            currentIndex=index;
            context.setLocale(Locale(languagesCodes[index]));
            CashHelper.saveLanguage(languagesCodes[index]);
          });
        },),
        SizedBox(width: 4.w,),
        Text(languages[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),)
      ],
    );
  }
}
