import 'package:dio/dio.dart';
// https://newsapi.org/
// v2/top-headlines?
// country=us&category=business&apiKey=aab5331f8ee841c6af133ce96d3832e8
class DioHelper
{
  static late Dio dio;

  static inti(){
     dio=Dio(
       BaseOptions(
         baseUrl:"https://newsapi.org/",
         receiveDataWhenStatusError: true,
       )
     );
  }

  static Future<Response> getData({
    required String url,
    required Map<String,dynamic> query,
  })async
  {
    return   await dio.get(url,queryParameters: query);

  }
}