import 'package:flutter_cubit_changetheme/features/movies/cubit.dart';
import 'package:kiwi/kiwi.dart';

void initKiwi(){
  final kiwi=KiwiContainer();

  kiwi.registerFactory((container) => MoviesCubit());

}