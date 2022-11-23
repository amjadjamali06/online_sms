/* Created By: Amjad Jamali on 22-Nov-2022 */

import 'package:online_sms/models/response_model.dart';
import 'package:online_sms/services/rest_api_url.dart';


import 'http_client.dart';

class UserService{
  late HTTPClient _httpClient;

  factory UserService(){
    return _instance;
  }

  static final UserService _instance = UserService._constructor();

  UserService._constructor(){
    _httpClient = HTTPClient();
  }

  Future<dynamic> registrationSendOtpService({required String phoneNumber}) async {
    Map<String,String> requestBody = {'phoneNumber':phoneNumber};

    ResponseModel responseModel = await _httpClient.postRequest(url:kGenerateOTPURL,body:requestBody);
    if(responseModel.data!=null && responseModel.statusCode==200 && responseModel.data is int){
      return 'Otp sent successfully';
    }
    return responseModel.data;
  }


}