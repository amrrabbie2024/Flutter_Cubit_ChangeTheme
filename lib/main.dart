import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_changetheme/core/get_it.dart';
import 'package:flutter_cubit_changetheme/core/kiwi.dart';
import 'package:flutter_cubit_changetheme/core/logic/cash_helper.dart';
import 'package:flutter_cubit_changetheme/views/change_theme/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/helper_methods.dart';
import 'features/change_theme/cubit.dart';
import 'views/carousel_slider/view.dart';
import 'views/image_picker/view.dart';
import 'views/movies/view.dart';
import 'views/pages_view/view.dart';
import 'views/svg/view.dart';
import 'views/translations/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CashHelper.init();
  initKiwi();
  initGetIt();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('fr'),Locale('ar')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('ar'),
        startLocale: Locale('en'),
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return BlocProvider(
            create: (BuildContext context) => ChangeThemesCubit(),
            child: BlocBuilder<ChangeThemesCubit, ThemesStates>(
              builder: (context, state) {
                return MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  //locale: context.deviceLocale,
                  navigatorKey: navigtorKey,
                  title: 'Change Themes',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    brightness: Brightness.light,
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.yellow,primary: Colors.orange),
                    appBarTheme: AppBarTheme(
                        titleTextStyle: TextStyle(color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                        centerTitle: true
                    ),

                    filledButtonTheme: FilledButtonThemeData(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          side:  BorderSide(color: Colors.orange)
                        )
                      )
                    ),

                    outlinedButtonTheme:  OutlinedButtonThemeData(
                      style: OutlinedButton.styleFrom(
                        textStyle: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 21),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          side: BorderSide(color: Colors.green)
                        )
                      )
                    ),
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    scaffoldBackgroundColor: Colors.black,
                    appBarTheme: AppBarTheme(

                        titleTextStyle: TextStyle(color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                        centerTitle: true
                    ),
                  ),
                  themeMode: state is DarkThemeState
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: const PagesViewerView(),
                );
              },
            ),
          );
        }
    );
  }
}


