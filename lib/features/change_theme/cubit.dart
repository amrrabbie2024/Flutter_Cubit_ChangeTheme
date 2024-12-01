import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';

class ChangeThemesCubit extends Cubit<ThemesStates>{
  ChangeThemesCubit():super(ThemesStates());

  bool isDarkTheme=false;

  void changeMyAppTheme(){
    isDarkTheme=!isDarkTheme;
    if(isDarkTheme)
      emit(DarkThemeState());
    else
      emit(LightThemeState());
  }

}