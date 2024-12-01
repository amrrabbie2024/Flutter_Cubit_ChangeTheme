import 'package:dio/dio.dart';

class DioHelper{

  static final _dio=Dio(
      BaseOptions(
          baseUrl: "https://api.themoviedb.org/3/",
          headers: {

          }
      )
  );

  static Future<CustomResponse> send(String path,{Map<String,dynamic>? data}) async {
    print("Post  https://api.themoviedb.org/3/$path");
    print("data $data");
    try {
      final response = await _dio.post(path, data: data);
      print(response.data);
      return CustomResponse(isSucess: true,data: response.data,statusCode: response.statusCode);
    }on DioException catch (ex){
      print(ex.response?.data);
      return CustomResponse(isSucess: false,data: ex.response?.data,statusCode: ex.response?.statusCode,
          // msg: ex.error.toString()
          msg: ex.response?.data["status_message"]
      );
    }catch(e){
      print("Error:- ${e.toString()}");
      return CustomResponse(isSucess: false,data: e.toString(),statusCode: 401,
          //msg: ex.error.toString()
          msg: e.toString()
      );
    }
  }

  static Future<CustomResponse> get(String path,{Map<String,dynamic>? data}) async {
    print("Get  https://api.themoviedb.org/3/$path");
    print("data $data");

    try {
      final response = await _dio.get(path, queryParameters: data);
      print(response.data);
      return CustomResponse(
          isSucess: true, data: response.data, statusCode: response.statusCode);
    }on DioException catch(ex){
      print(ex.response?.data);
      return CustomResponse(isSucess: false,data: ex.response?.data,statusCode: ex.response?.statusCode,
          //msg: ex.error.toString()
          msg: ex.response?.data["status_message"]
      );
    }catch(e){
      print("Error:- ${e.toString()}");
      return CustomResponse(isSucess: false,data: e.toString(),statusCode: 401,
          //msg: ex.error.toString()
          msg: e.toString()
      );
    }
  }

}

class CustomResponse{
  final String msg;
  final int? statusCode;
  final bool isSucess;
  final data;

  CustomResponse({ this.msg="", this.statusCode,required this.isSucess, this.data});
}