

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({super.key});

  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

XFile? image;

class _ImagePickerViewState extends State<ImagePickerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              image!=null?CircleAvatar(radius: 80,backgroundColor: Theme.of(context).primaryColor,
              child: CircleAvatar(radius: 77,backgroundImage: FileImage(File(image!.path)),),):SizedBox.shrink(),
              SizedBox(height: 16.h,),
              SizedBox(
                height: 45.h,
                child: FilledButton.icon(onPressed: () async {
                    image=await ImagePicker().pickImage(source: ImageSource.gallery);
                    setState(() {});
                }, icon: Icon(Icons.browse_gallery), label: Text("From gallery ...",style: TextStyle(color: Colors.green,fontSize: 21,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 16.h,),
              SizedBox(
                height: 45.h,
                child: OutlinedButton.icon(onPressed: () async {
                  image= await ImagePicker().pickImage(source: ImageSource.camera);
                  setState(() {});
                }, icon: Icon(Icons.camera), label: Text("From camera ...",style: TextStyle(color: Colors.blue,fontSize: 21,fontWeight: FontWeight.bold),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
