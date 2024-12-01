import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgView extends StatelessWidget {
  const SvgView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        child: SvgPicture.asset("assets/svg/logo.svg",width: double.infinity,height: 180.h,fit: BoxFit.fill,)));
  }
}
