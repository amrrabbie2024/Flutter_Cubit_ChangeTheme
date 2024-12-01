import 'package:flutter_cubit_changetheme/features/movies/cubit.dart';
import 'package:get_it/get_it.dart';

void initGetIt(){
  final getit=GetIt.instance;

  getit.registerFactory(() => MoviesCubit());

}