class ErroeModel {
  String? message;
  int? statusCode;

  ErroeModel({this.message, this.statusCode});

  ErroeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

}