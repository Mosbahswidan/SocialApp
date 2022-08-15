import 'package:dio/dio.dart';

class DioHelper{
    static Dio? dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/send',
        receiveDataWhenStatusError: true,
      ),
    );
  }
   static Future<Response> getData({
  required String url,
     Map<String,dynamic>? query,
     String lang='en',
     String? token,

   })async{
     dio!.options.headers={
       'Content-Type':'application/json',
       'lang':lang,
       'Authorization':token??'',

     };
   return await dio!.get(url,queryParameters:query);
  }

    static Future<Response> postData({
  required String url,
      Map<String,dynamic>? query,
      required Map<String,dynamic> data,

})async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'key=AAAAcIIkw1I:APA91bH48zo-jMPjYr79jN5j76cDjvReDU2oCNS5rj3hl2ECNAmue5exrzljQNgC174T2jflgTXWHWJPmuxJWla2R-ZXV6hSrQ3LvToeoJMAbmGzXYjrRTagBl3Gsr57V6V_Sogqfozt',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
    }


    static  Future<Response> putData({
      required String url,
      Map<String, dynamic>?query,
      required Map<String, dynamic>data,
      String lang = 'en',
      String? token,
    })async
    {
      dio!.options.headers =
      {
        'Content-Type' : 'application/json',
        'lang' : lang,
        'Authorization' : token??'',
      };
      return await dio!.put(
        url,
        data: data,
        queryParameters: query,
      );
    }
}