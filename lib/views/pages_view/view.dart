import 'package:flutter/material.dart';
import 'package:flutter_cubit_changetheme/views/carousel_slider/view.dart';
import 'package:flutter_cubit_changetheme/views/change_theme/view.dart';
import 'package:flutter_cubit_changetheme/views/image_picker/view.dart';
import 'package:flutter_cubit_changetheme/views/movies/view.dart';
import 'package:flutter_cubit_changetheme/views/svg/view.dart';
import 'package:flutter_cubit_changetheme/views/translations/view.dart';

class PagesViewerView extends StatefulWidget {
  const PagesViewerView({super.key});

  @override
  State<PagesViewerView> createState() => _PagesViewerViewState();
}

class _PagesViewerViewState extends State<PagesViewerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          ChangeThemeView(),
          MoviesView(),
          ImagePickerView(),
          ChangeLanguageView(),
          CarouselSliderView(),
          SvgView()
        ],
      ),
    );
  }
}
