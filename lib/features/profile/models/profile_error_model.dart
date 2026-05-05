class ProfileErrorModel {
  String? message;
  int? statusCode;

  ProfileErrorModel({this.message, this.statusCode});

  ProfileErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

}