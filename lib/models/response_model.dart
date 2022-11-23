/*@Author Hina Hussain
* Created Date: 26-May-2021
* Last Modified by: Sadaf Khowaja on 26-Oct-2021
  */

class ResponseModel {
  int statusCode = -1;
  String statusDescription = "";
  dynamic data;


  ResponseModel();

  ResponseModel.named({required this.statusCode, required this.statusDescription, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    this.statusCode = json["statusCode"] ?? -1;
    this.statusDescription = json["statusDescription"] ?? "";
    this.data = json["data"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': this.statusCode,
      'statusDescription': this.statusDescription,
      'data': this.data,
    };
  }

  @override
  String toString() {
    return 'ResponseModel{statusCode: $statusCode, statusDescription: $statusDescription, data: $data}';
  }
}
