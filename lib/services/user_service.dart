/* Created By: Amjad Jamali on 22-Nov-2022 */

import 'package:online_sms/models/response_model.dart';
import 'package:online_sms/services/rest_api_url.dart';
import 'package:online_sms/utils/user_session.dart';


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

  Future<ResponseModel> sendOTP({required String phoneNumber}) async {
    Map<String,String> requestBody = {'phoneNumber':phoneNumber};

    ResponseModel responseModel = await _httpClient.postMultipartRequest(url:kGenerateOTPURL,body:requestBody);

    return responseModel;
  }

  Future<String> sendSMSService({required String phoneNumber,required String message}) async {
    Map<String,String> requestBody = {
      'phoneNumber':"+923166276765",//phoneNumber,
      'fromNumber': "+923000838330",//await UserSession().getMobileNumber(),
      'messageBody':message
    };

    ResponseModel responseModel = await _httpClient.postRequest(url:kSendMessageURL,body:requestBody);
    print('-------------------------->>>>. ${responseModel.toString()}');
    if(responseModel.data!=null && responseModel.statusCode==200 && responseModel.data is String && responseModel.data == "The Message Has Been Sent Successfully "){
      return 'Message sent successfully';
    }
    return "${responseModel.data}";
  }


}