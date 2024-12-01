import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_changetheme/core/constants.dart';
import 'package:flutter_cubit_changetheme/core/design/app_failed.dart';
import 'package:flutter_cubit_changetheme/core/design/app_loading.dart';
import 'package:flutter_cubit_changetheme/core/logic/helper_methods.dart';
import 'package:flutter_cubit_changetheme/features/movies/cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

class MoviesView extends StatefulWidget {
  const  MoviesView({super.key});

  @override
  State< MoviesView> createState() => _MoviesViewState();
}

final kbloc=KiwiContainer().resolve<MoviesCubit>();
final gbloc=GetIt.I<MoviesCubit>();

class _MoviesViewState extends State< MoviesView> {
  @override
  void initState() {
    kbloc.getMoviesData();
    gbloc.getMoviesData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movies app",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: BlocConsumer(
          bloc: kbloc,
          buildWhen: (previous, current) => current is MoviesSuccessState || current is MoviesFailedState || current is MoviesLoadingState,
          listener: (context, state) {
            if(state is MoviesFailedState)
              showMessage(state.msg);
            else if(state is MoviesSuccessState)
              showMessage("Success, Items count is ${state.movies.length}",isSucess: true);
            else if(state is MoviesPaginationState)
              _showProgressDialog(state.msg);
            else if(state is MoviesPaginationFinishedState)
              showMessage(state.msg!);
          },
          builder: (context, state) {
            if(state is MoviesFailedState)
              return AppFailed(msg: state.msg);
            else if(state is MoviesSuccessState)
              return _grid(state.movies);
            else
              return AppLoading();
          },
        ),
      ),
    );
  }

  Widget _grid(List<MovieModel> movies) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          kbloc.getMoviesData();
        }
        return true;
      },
      child: GridView.builder(
         // shrinkWrap: true,
          //physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: .5
          ),
          itemBuilder: (context, index) =>  _item(movies[index]),
        itemCount: movies.length,
      ),
    );
  }

  Widget _item(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        showMessage(movie.title+"\n"+movie.releaseDate,isSucess: true);
      },
      child: Card(
        color: Colors.yellow.withOpacity(.3),
        shadowColor: Theme.of(context).primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
          side: BorderSide(color: Theme.of(context).primaryColor)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("${Constants.Movie_Image_base_Url}${movie.posterPath}",width: MediaQuery.of(context).size.width,height: 180.h,fit: BoxFit.fill,),
            SizedBox(height: 8.h,),
            Directionality(textDirection: TextDirection.ltr,child: Text(movie.title,style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            SizedBox(height: 8.h,),
            Text(movie.releaseDate,style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(movie.voteAverage.toString(),style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
                SizedBox(width: 4.w,),
                Icon(Icons.star,color: Colors.amber,size: 32.r,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showProgressDialog(String? msg) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8.h,),
                Text(msg!, style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }
}
