import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get_connect/connect.dart';


import '../models/response_model.dart';


/* Created By: Amjad Jamali on 22-Nov-2022 */

class HTTPClient extends GetConnect{

  factory HTTPClient(){
    return _instance;
  }
  static const int _requestTimeOut = 15;
  static final HTTPClient _instance = HTTPClient._constructor();

  HTTPClient._constructor();

  Future<ResponseModel> postRequest({required String url,dynamic body})async{
    try{

        Response response = await post(
                 url, body,
             ).timeout(const Duration(seconds: _requestTimeOut));
        log('════════════════════5body> $body');
        log('════════════════════5url> $url');
        log('════════════════════5Response.body> ${response.body}');
        ResponseModel responseModel;
        if(response.body is List) {
          responseModel = ResponseModel.named(statusCode: 200, statusDescription: "Success");
          responseModel.data = response.body;
        }else {
          responseModel = ResponseModel.fromJson(jsonDecode(response.bodyString!));
        }
        return responseModel;

    }
    on TimeoutException catch (_) {
      return Future.value(ResponseModel.named(statusCode:408, statusDescription:"Request TimeOut", data:""));
    } on SocketException catch (_) {
      return Future.value(ResponseModel.named(statusCode:400, statusDescription:"Bad Request", data:""));
    }catch(e){
      return Future.value(ResponseModel.named(statusCode:500, statusDescription:"Server Error", data:"Server Error"));
    }
  }


  Future<ResponseModel> getRequest({required String url})async{
    try{

        Response response = await get(url)
            .timeout(const Duration(seconds: _requestTimeOut));
        log('════════════════════3url> $url');
        log('════════════════════3Response.body> ${response.body}');
        ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
        return responseModel;

    }
    on TimeoutException catch (_) {
      return Future.value(ResponseModel.named(statusCode:408, statusDescription:"Request TimeOut", data:""));
    } on SocketException catch (_) {
      return Future.value(ResponseModel.named(statusCode:400, statusDescription:"Bad Request", data:""));
    }catch(_){
      return Future.value(ResponseModel.named(statusCode:500, statusDescription:"Server Error", data:""));
    }
  }


}