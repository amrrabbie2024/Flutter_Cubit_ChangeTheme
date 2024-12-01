import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSliderView extends StatefulWidget {
  const CarouselSliderView({super.key});

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

final images=["img1.jpg","img2.jpg","img3.jpg","img4.jpg","img5.jpg"];
int currentIndex=0;
class _CarouselSliderViewState extends State<CarouselSliderView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
              items: List.generate(images.length, (index) =>  _item(index)),
              options: CarouselOptions(
                height: 350.h,
                scrollDirection: Axis.vertical,
                enlargeCenterPage: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex=index;
                  });
                },
          )
          ),
          SizedBox(height: 16.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(images.length, (index) {
                return CircleAvatar(radius: 15.r,backgroundColor: currentIndex==index?Colors.green:Colors.transparent,
                child: CircleAvatar(radius: 12.r,backgroundColor: currentIndex==index?Theme.of(context).primaryColor:Colors.grey,),);
              })
            ],
          )
        ],
      ),
    );
  }

  Widget _item(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r)
    ,child: Image.asset("assets/images/${images[index]}",width: MediaQuery.of(context).size.width,height: 350.h,fit: BoxFit.fill,));
  }
}
