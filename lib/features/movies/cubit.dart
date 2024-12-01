import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_changetheme/core/constants.dart';
import 'package:flutter_cubit_changetheme/core/logic/dio_helper.dart';

part 'states.dart';
part 'model.dart';

class MoviesCubit extends Cubit<MoviesStates>{
  
  List<MovieModel> _list=[];
  bool isLoading=true;
  bool isPagination=false;
  int currentPage=1;
  MoviesCubit():super(MoviesStates()){

  }

  Future<void> getMoviesData() async {
    if(isLoading){
      isLoading=false;
      isPagination=true;
      emit(MoviesLoadingState());
    }else{
      emit(MoviesPaginationState(msg: "More data loading ..."));
    }

    final response=await DioHelper.get("discover/movie",data: {
      "api_key": Constants.Movies_Api_Key,
      "page":currentPage
    });

    if(response.isSucess){
      final model=MoviesData.fromJson(response.data);

      //if(model.totalPages > currentPage){
      if(7 > currentPage){
        currentPage++;
        _list.addAll(model.movies);
        emit(MoviesSuccessState(movies: _list));
      }else{
        emit(MoviesPaginationFinishedState(msg: "No more data aviable!"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(MoviesFailedState(msg: response.msg));
    }
  }

}